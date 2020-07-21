#!/bin/bash
#
# [Japanese]
# macOS の /Application フォルダにインストール済みの
# 複数のPAServerを対話的なインタフェースで選択起動できるスクリプト
#
# homebrew で peco or percol をインストールしていればとても便利に、
# なくてもそれなりに便利に使えます
#
# [English]
# PAServer selective launcher with interactive interface.
#
# if you have peco or percol by installing homebrew,
# you can edit shell env "interactive_helper"
# to put fullpath for it.
#
# history
# 2017/03/22 Find other paserver process is alreay running or not.
#            実行中の paserver が存在するかどうかを確認する処理を追加
# 2020/07/21 use ~/.passerverrc for configuration if exist 
#            ~/.paserverrc が存在した場合は自動的に設定ファイルとして使用します
#	        

# 配列の定義
declare -a list_paserver=()

# OS に依存する設定の初期化
OSTYPE=$( uname );
case ${OSTYPE} in
	Darwin)
	paserver_path_prefix="/Applications"
	paserver_path_surffix="Contents/MacOS"
	paserver_rc="${HOME}/.paserverrc"
	CURRENT_LOCALE=$(defaults read -g AppleLocale)
	;;

	Linux)
	paserver_path_prefix="~/PAServer-*"
	paserver_path_surffix=""
	paserver_rc="${HOME}/.paserverrc"
	CURRENT_LOCALE=$LANG
	;;
esac
#pwd
#ls -l ${paserver_rc}

if [ -e "${paserver_rc}" ]; then
	paserver_option="-config=${paserver_rc}"
else
	paserver_option="-scratchdir=~/PAServer/scratch-dir"
fi

# peco や percol がある場合はフルパスを指定しておく
# specify peco or percol full path.
interactive_helper=/usr/local/bin/peco

do_main() {

  unset i
  find_other_paserver_processes_is_running

  # interactive_helper の有無によって処理を切り替える
  if [ -e "${interactive_helper}" ]; then
    cmd_paserver=${paserver_path_prefix}/$( cd ${paserver_path_prefix} ; ls -dr PAServer-* | "${interactive_helper}" )/${paserver_path_surffix}/paserver
    if [ -e "${cmd_paserver}" ]; then
#      echo "${cmd_paserver}" "${paserver_option}"
      exec "${cmd_paserver}" "${paserver_option}"
    else
      echo "Abort."
      exit 0
    fi
  else
    scan_paserver_path
    set_language_dependent_message
    show_menu
    while : ; do
      read -p "$disp_message" i
      echo ""

      # 入力値が数値かどうかの判定。expr の戻り値が $? 未満なら数値
      expr ${i} + 0 > /dev/null 2>&1

      if [ $? -lt 2 ] && [ 0 -le ${i} ] && [ ${i} -lt ${#list_paserver[@]} ]; then

        # 入力値が配列の添え字として有効なら対応するPAServerを実行する
    	cmd_paserver=${paserver_path_prefix}/${list_paserver[${i}]}/${paserver_path_surffix}/paserver
        if [ -e ${cmd_paserver} ]; then
          exec "${cmd_paserver}" "${paserver_option}"
        fi
      fi

      # 指定値が不正な場合や、PAServerが存在しない場合はメニューの表示を続ける
      show_menu
    done
  fi
}

# 実行済みのPAServerが存在するかどうかを探す 
find_other_paserver_processes_is_running()  {
	pgrep -f -l paserver
	if [ $? -eq 0 ]; then
	  case "${CURRENT_LOCALE:0:2}" in
	    'ja' ) echo "処理を中止します。起動中のPAServerを検出しました。"         ;;
	    *    ) echo "abort. another paserver is still running..."  ;;
	  esac
	  exit 1
	fi
}

# peco や percol を使わない場合の対話インタフェース用のメッセージ
set_language_dependent_message() {
  case "${CURRENT_LOCALE:0:2}" in
    'ja' ) disp_message="起動したいPAServerを選んでください: "         ;;
    'de' ) disp_message="Bitte wählen Sie PAServer zum Starten: "      ;;
    'fr' ) disp_message="Veuillez sélectionner PAServer pour lancer: " ;;
    *    ) disp_message="Please select PAServer to launch: "           ;;
  esac
}

# peco や percol を使わない場合に PAServer を探す処理
scan_paserver_path() {
  for dir in $( cd ${paserver_path_prefix} ; ls -d PAServer-* | sort -r ) ; do
    list_paserver+=( $dir )
  done
}

# peco や percol を使わない場合の選択メニュー表示
show_menu() {
  echo ""
  i=0
  for enum in ${list_paserver[@]}; do
    echo "$i) ${enum}"
    let i++
  done
}

# メイン処理を do_main に押し込むための小細工
do_main "$@"
