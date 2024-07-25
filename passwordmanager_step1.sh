#!/bin/bash


read -p "サービス名を入力してください;" sername
read -p "ユーザー名を入力してください;" usrname
read -p "パスワードを入力してください;" passname
#入力文字のパターン
pattern='^[a-zA-Z0-9_&?.]{4,10}$'

#入力文字のパターンに満たさなければ戻る
if [[ ! "${sername}" =~ ${pattern} ]]; then
echo '入力文字には半角英数字,"_","&","?","."かつ長さ4～10以外は入力できません'
exit
fi

if [[ ! "${usrname}" =~ ${pattern} ]]; then
echo '入力文字には半角英数字,"_","&","?","."かつ長さ4～10以外は入力できません'
exit
fi

if [[ ! "${passname}" =~ ${pattern} ]]; then
echo '入力文字には半角英数字,"_","&","?","."かつ長さ4～10以外は入力できません'
exit
fi

#ファイルがない場合作成
if [ ! -f usrinfo ]; then
touch usrinfo
fi


#パスワードマネージャーに同じサービス名が登録されているかチェック
sercheck=`awk -F: ' $1=="'"$sername"'" {print $1}' usrinfo `


#登録されていた場合
if [ -n "${sercheck}" ]; then
echo "同じサービス名がすでに登録されています"

	while true; do
	#パスワードを更新するか確認
	read -p "ユーザー名とパスワードを更新されますか?(y/n)" yorn

	if [ "${yorn}" != n ] && [ "${yorn}" != y ]; then
	echo "yまたはnを入力してください"
	continue
	fi

	if [ "${yorn}" = n ]; then
	echo "処理を終了します"
	fi
	
	break
	
	done
fi


#パスワード更新時のyorn変数がnの場合機能選択画面に戻る
if [ "${yorn}" = "n"  ]; then
exit
fi

#パスワード更新時のyorn変数がyの場合パスワードマネージャーを更新し機能選択画面に戻る
if [ "${yorn}" = "y" ]; then
sed -i "/^${sercheck}:/c ${sername}:${usrname}:${passname}" usrinfo
echo "更新が完了しました"
exit
fi

#新規に登録の場合
echo "${sername}:${usrname}:${passname}" >> usrinfo
echo -e 'Tank you\e[31m!\e[m'
exit


