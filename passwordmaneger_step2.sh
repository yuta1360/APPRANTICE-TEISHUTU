#!/bin/bash


echo "パスワードマネージャーにようこそ"
while true; do

read -p "次の選択肢から入力してください(Add Password/Get Password/Exit);" funcchose

#Add Passwordを選択した場合
if [ "${funcchose}" = "Add Password" ]; then
	read -p "サービス名を入力してください;" sername
	read -p "ユーザー名を入力してください;" usrname
	read -p "パスワードを入力してください;" passname
	#入力文字のパターン
	pattern='^[a-zA-Z0-9_&?.]{4,10}$'

	#入力文字のパターンに満たさなければ戻る
	if [[ ! "${sername}" =~ ${pattern} ]]; then
	echo '入力文字には半角英数字,"_","&","?","."かつ長さ4～10以外は入力できません'
	continue
	fi

	if [[ ! "${usrname}" =~ ${pattern} ]]; then
	echo '入力文字には半角英数字,"_","&","?","."かつ長さ4～10以外は入力できません'
	continue
	fi

	if [[ ! "${passname}" =~ ${pattern} ]]; then
	echo '入力文字には半角英数字,"_","&","?","."かつ長さ4～10以外は入力できません'
	continue
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
		echo "選択画面にもどります"
		fi
	
		break
	
		done
		fi


	#パスワード更新時のyorn変数がnの場合機能選択画面に戻る
	if [ "${yorn}" = "n"  ]; then
	continue
	fi

	#パスワード更新時のyorn変数がyの場合パスワードマネージャーを更新し機能選択画面に戻る
	if [ "${yorn}" = "y" ]; then
	sed -i "/^${sercheck}:/c ${sername}:${usrname}:${passname}" usrinfo
	echo "更新が完了しました"
	continue
	fi

	#新規に登録の場合
	echo "${sername}:${usrname}:${passname}" >> usrinfo
	echo "パスワードの追加は成功しました。"

fi




#Get Passwordを選択した場合
if [ "${funcchose}" = "Get Password" ]; then

	#パスワードマネージャーファイルがない場合機能選択に戻る
	if [ ! -f usrinfo ]; then
	echo "パスワードマネージャーファイルが作成されていないので照会できません"
	continue
	fi

	read -p "サービス名を入力してください;" sername
	#入力チェック
	pattern='^[a-zA-Z0-9_&?.]{4,10}$'
	
	if [[ ! "${sername}" =~ ${pattern} ]]; then
	echo '入力文字には半角英数字,"_","&","?","."かつ長さ4～10以外は入力できません'
	continue
	fi
	
	#パスワードマネージャーファイルにサービスネームがあるかどうか確認
	sercheck=`awk -F: -v OFS=: ' $1=="'"$sername"'" {print $1,$2,$3 }' usrinfo `

	#ない場合は選択画面に戻る
	if [ -z "${sercheck}" ]; then
	echo "そのサービスは登録されていません"
	continue
	fi
	
	#ある場合は表示を行う
	sername=`echo "${sercheck}" | cut -d ":" -f 1`
	usrname=`echo "${sercheck}" | cut -d ":" -f 2`
	passname=`echo "${sercheck}" | cut -d ":" -f 3`
	echo "サービス名:${sername}"
	echo "ユーザー名:${usrname}"
	echo "パスワード:${passname}"

fi
#機能選択でExitが入力された場合
if [ "${funcchose}" = "Exit" ]; then
	echo -e 'Tank you\e[31m!\e[m'
	exit
fi

#選択画面の選択肢以外が入力された場合
if [ "${funcchose}" != "Exit" ] && [ "${funcchose}" != "Get Password" ] && [ "${funcchose}" != "Add Password" ]; then
	echo "入力を間違えています"
fi

done