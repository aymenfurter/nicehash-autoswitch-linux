#/bin/sh
# you need to install jq! 
# AutoSW

#0 "Scrypt"
#1 "SHA256" 
#2 "ScryptNf" 
#3 "X11"
#4 "X13"
#5 "Keccak"
#6 "X15"
#7 "Nist5"
#8 "NeoScrypt"
#9 "Lyra2RE"
#10 "WhirlpoolX"
#11 "Qubit"
#12 "Quark"
#13 "Axiom"
#14 "Lyra2REv2"
#15 "ScryptJaneNf16"
#16 "Blake256r8"
#17 "Blake256r14"
#18 "Blake256r8vnl"
#19 "Hodl"
#20 "DaggerHashimoto"
#21 "Decred"
#22 "CryptoNight"
#23 "Lbry"
#24 "Equihash"
#25 "Pascal"
#26 "X11Gost"
#27 "Sia"

currentAlgo=0
algoSet=false


algo=$(curl -s 'https://www.nicehash.com/calc' -H 'Origin: https://www.nicehash.com' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' -H 'Accept: */*' -H 'Referer: https://www.nicehash.com/?p=calc' -H 'X-Requested-With: XMLHttpRequest' --data 'hwname=NVIDIA+GTX+1080&icost=500.00&power=180.00&fa0=0.00&fa1=0.00&fa2=0.00&fa3=0.00&fa4=0.00&fa5=0.00&fa6=0.00&fa7=0.00&fa8=0.37&fa9=0.00&fa10=0.00&fa11=0.00&fa12=0.00&fa13=0.00&fa14=49.11&fa15=0.00&fa16=0.00&fa17=0.00&fa18=0.00&fa19=0.00&fa20=27.63&fa21=3.09&fa22=0.48&fa23=0.32&fa24=470.00&fa25=1.36&fa26=16.20&fa27=2.28&elcost=0&recaptcha_challenge_field=03AOPBWq-QebBhXPImJL5yLnUhypa6RisTBDzRe6UsV_VasitAmKx6Qhr3F7PhtERc3RiTBNrCgNMVPOSg7ESq23O4v9f5ATETvF1xZPEjICLRnL6UWoULKLKexR9znILFx3YL9q2ozNR_0XtwGJRGBsHS_7h8VQNUewhyV1JKe5Gh_XXkc_zD21oKhKYo5he5XwMBOVvqlVtn&recaptcha_response_field=' | tac | jq -r '.current_algo')
echo $algo

while [ true ]
do
	algoSet=false

    if [ "$algo" -eq "14" ]; then
    	algoSet=true
	   	echo "Lyra2REv2"
	   	if [ "$algo" -eq "$currentAlgo" ]; then
	   		echo "same algo, no action needed"
	   	else
	   		echo "New Algo! Lets kill current process and start new one!"
	   		pkill -f ccminer
	   		pkill -f nhe
	   		nohup ./ccm/ccminer/ccminer -a Lyra2REv2 -o stratum+tcp://lyra2rev2.eu.nicehash.com:3347 -u 1KdMRzZjTPNVoUD4oYszKYJSVCWgFSKq2X -p x &>/dev/null &
	   	fi
	fi
#
#	if [ "$algo" -eq "20" ]; then
#		algoSet=true
#	   	echo "DaggerHashimoto"
#
#	   	if [ "$algo" -eq "$currentAlgo" ]; then
#	   		echo "Same algo, no action needed"
#	   	else
#	   		echo "New Algo! Lets kill current process and start new one!"
#	   	fi
#
#	fi
#
	
	if [ "$algo" -eq "23" ]; then
		algoSet=true
	   	echo "Lbry"

	   	if [ "$algo" -eq "$currentAlgo" ]; then
	   		echo "Same algo, no action needed"	   		
	   	else
	   		pkill -f ccminer
	   		pkill -f nhe
	   		nohup ./ccm/ccminer/ccminer -a lbry -o stratum+tcp://lbry.eu.nicehash.com:3356 -u 1KdMRzZjTPNVoUD4oYszKYJSVCWgFSKq2X -p x &>/dev/null &
	   	fi
	fi

	if [ "$algo" -eq "24" ]; then
		algoSet=true
	   	echo "Equihash"

	   	if [ "$algo" -eq "$currentAlgo" ]; then
	   		echo "same algo, no action needed"
	   	else
	   		echo "New Algo! Lets kill current process and start new one!"
	   		pkill -f ccminer
	   		pkill -f nhe
			nohup ~/nh/build/nheqminer -l equihash.eu.nicehash.com:3357 -u 1KdMRzZjTPNVoUD4oYszKYJSVCWgFSKq2X -cd 0 &>/dev/null &
	   	fi
	fi
#
#	if [ "$algo" -eq "25" ]; then
#		algoSet=true
#	  	echo "Pascal"
#
#	  	if [ "$algo" -eq "$currentAlgo" ]; then
#	   		echo "Same algo, no action needed"
#	   	else
#	   		echo "New Algo! Lets kill current process and start new one!"
#	   	fi
#	fi
#
#	if [ "$algo" -eq "26" ]; then
#		algoSet=true
#	   	echo "X11Gost"
#
#	   	if [ "$algo" -eq "$currentAlgo" ]; then
#	   		echo "Same algo, no action needed"
#	   	else
#	   		echo "New Algo! Lets kill current process and start new one!"
#	   	fi
#	fi
#
#	if [ "$algo" -eq "27" ]; then
#		#algoSet=true
#	   	echo "Sia, sadly not supported right now :-("
#
#	   	if [ "$algo" -eq "$currentAlgo" ]; then
#	   		echo "Same algo, no action needed"
#	   	else
#	   		echo "New Algo! Lets kill current process and start new one!"
#	   	fi
#	fi

	if [ "$algoSet" = false ]; then
		echo "not found, using Lyra."

		if [ "$algo" -eq "$currentAlgo" ]; then
	   		echo "Same algo, no action needed"
	   	else
	   		echo "New Algo! Lets kill current process and start new one!"
		 	pkill -f ccminer
	   		pkill -f nhe
			nohup ~/nh/build/nheqminer -l equihash.eu.nicehash.com:3357 -u 1KdMRzZjTPNVoUD4oYszKYJSVCWgFSKq2X -cd 0 &>/dev/null &
	   	fi	   	
	fi

	currentAlgo=$algo

    sleep 10
    #sleep 5m
done

