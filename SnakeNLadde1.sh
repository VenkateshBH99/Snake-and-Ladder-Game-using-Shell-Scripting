#!/bin/bash
tput clear
WinPoint=100
startgame()
{  tput cup 5 17
# Set reverse video mode
bg1=`tput setab 3`
  fg1=`tput setaf 1`
  bg2=`tput setab 4`
  reset=` tput sgr0`
  

 tput rev
 tput setaf 1
 tput bold
 tput cup 1 15
  tput blink;echo -e "\n~~~~~@ [ WELCOME TO SNAKE AND LADDER ] |-| |-| |-|\n"
  tput sgr0
  
    printf " ----------------------------------------\n"
    printf "| ${bg1}${fg1}100 99  98  97  96  95  94  93  92  91${reset} |  |    1=START          99=SNAKE to 54\n"
    printf "| ${bg2}${fg1}81  82  83  84  85  86  87  88  89  90${reset} |  |    6=LADDER to 25   100=END\n"
    printf "| ${bg1}${fg1}80  79  78  77  76  75  74  73  72  71${reset} |  |   11=LADDER to 40\n"
    printf "| ${bg2}${fg1}61  62  63  64  65  66  67  68  69  70${reset} |  |   17=LADDER to 69\n"
    printf "| ${bg1}${fg1}60  59  58  57  56  55  54  53  52  51${reset} |  |   25=SNAKE  to  2\n"
    printf "| ${bg2}${fg1}41  42  43  44  45  46  47  48  49  50${reset} |  |   46=LADDER to 90\n"
    printf "| ${bg1}${fg1}40  39  38  37  36  35  34  33  32  31${reset} |  |   52=SNAKE  to 42\n"
    printf "| ${bg2}${fg1}21  22  23  24  25  26  27  28  29  30${reset} |  |   60=LADDER to 85\n"
    printf "| ${bg1}${fg1}20  19  18  17  16  15  14  13  12  11${reset} |  |   70=SNAKE  to 55\n"
    printf "| ${bg2}${fg1}1   2   3   4   5   6   7   8   9   10${reset} |  |   95=SNAKE  to 72\n"
    printf " ---------------------------------------- \n"
    
    tput setaf 2
   echo -ne  "\nWOULD YOU LIKE TO:\n1.Read the rules\n2.PLAY THE GAME\nEnter your CHOICE:"
    echo ""
    tput sgr0
    read c
    clear
    if [[ "$c" -eq "1" ]]; then
      tput setaf 1
    	    printf "\nThe rules are simple: \n   You press r to roll the die\n   You are then told which space you have landed on\n   If you land on a snake you will move down the board\n   If you land on a ladder then you will move up it\n   In order to win you must land on 100 exactly\n   If you go over 100 then your imaginary piece will be moved backwards for the remainder of your dice roll\n\n   Press 'q' or 'Q' and then press 'y' or 'Y' to Quit\n   Note: If you don't want to quit after pressing 'q' or 'Q' then you can press any key\n\n  Good Luck\n\n"
         tput sgr0
         tput blink;echo "GAME STARTS in Few seconds....";tput sgr0
         sleep 20

    fi
    if [[ "$c" -eq "1" || "$c" -eq "2" ]]; then

    	tput blink;echo -e "\n----GAME STARTS----";tput sgr0
    until [[ "$ch" -eq "3" ]]; do
      sleep 2.5
      clear
      tput setaf 6
      tput blink;echo "***** MENU ****";tput sgr0
      tput setaf 6
     echo -ne "1.Single player\n2.Multiplayer(two)\n3.Exit\nEnter your choice:"
     tput sgr0
     read ch
    case $ch in
       1) singleplayer
         ;;
       2)   multiplayer
          ;;
       3)  tput blink;echo "----GAME EXITS!!!!----";tput sgr0
           sleep 2;;
           
       *) tput blink;echo "INVALID CHOICE";tput sgr0
             
     esac
    done
    
    else
    	#echo "INVALID CHOICE"
      startgame
  

    fi

  tput clear
}
singleplayer()
{  clear
  echo -n "Enter  PLAYER name: "
   read first
   
   tput setaf 9
   tput bold
   tput blink;echo -e "\n-----GAME BEGINS-----\n";tput sgr0
   player1=1; player2=1

   tput setaf 3
    echo "FIRST PLAYER $first START POSITION :: $player1"
    echo "SECOND PLAYER BOT START POSITION :: $player2"
    tput sgr0
    echo -e "-------------------------------\n"
    sleep 3
   currplayer=-1
   dicevalue=0
   s1=r
   s2=r
   while :; do
    #first
    
   if [[ "$currplayer" -eq "-1" ]]; then
    clear
     bg=`tput setab 0`
      e=`tput sgr0`
      tput setaf 2
      echo "${bg}FIRST PLAYER $first :: $player1"
      echo "SECOND PLAYER BOT :: $player2${e}"
      echo "------------------------------------"
      mov
      echo "------------------------------------"
    tput setaf 3
   echo "FIRST PLAYER $first TURN:"
   echo "press r to roll Dice / press [q/Q] Quit the match"
   read s2
   if [[ "$s2" == "$s1" ]]; then

      tput setaf 1
      echo "Dice rolling..."
      sleep 1
    #dicevalue=$(($(($RANDOM%6))+1))
    dicevalue=$(echo "$RANDOM%6+1" |bc)
     echo "Dice VALUE=$dicevalue"
     tput sgr0
    CalculateValue $player1 $dicevalue
     player1=$?
     sleep 1.2
     tput setaf 13;echo "FIRST PLAYER $first :: $player1*";tput sgr0
     

     
    echo "-------------------------------"

     currplayer=1
     isWin $player1
     n2=$?
     if [[ "$n2" -eq "1" ]]; then

      tput setaf 13
     tput blink;echo -e "---FIRST PLAYER $first WINS---\n"
     tput sgr0
     return
     fi
    elif [[ "$s2" == "q" || "$s2" == "Q" ]]; then
    echo "DICE DID NOT ROLL"
    echo -n "Want to Quit! For YES:[y/Y],For NO:[any KEY]:"
    read w
       if [[ "$w" == "y" || "$w" == "Y" ]]; then
       	echo "PLAYER $first Quits"
        tput setaf 13
       	tput blink;echo -e "---SECOND PLAYER BOT WINS---\n"
        tput sgr0
       	break
       	else
       		echo ""
       		continue
       fi
    else
      echo "DICE DID NOT ROLL (run again and press $s1 to roll the dice)"
    fi
    tput sgr0
    sleep 1.7
    fi
    #bot
    if [[ "$currplayer" -eq "1" ]]; then
      clear
      
      bg=`tput setab 0`
      e=`tput sgr0`
      tput setaf 2
      echo "${bg}FIRST PLAYER $first :: $player1"
      echo "SECOND PLAYER BOT :: $player2${e}"
      echo "------------------------------------"
      mov
      echo "------------------------------------"
      tput setaf 2
    echo "SECOND PLAYER BOT TURN:"
     #dicevalue=$(($(($RANDOM%6))+1))
     tput sgr0
     tput setaf 1
     sleep 0.7
     echo "Dice rolling..."
     sleep 1
     dicevalue=$(echo "$RANDOM%6+1" |bc)
     echo "Dice VALUE=$dicevalue"
     tput sgr0
     CalculateValue $player2 $dicevalue
     player2=$?
     
     sleep 1.2
     tput setaf 13;echo "SECOND PLAYER BOT :: $player2*";tput sgr0
     echo "-------------------------------"
     currplayer=-1
     isWin $player2
     n2=$?
     if [[ "$n2" -eq "1" ]]; then
      tput setaf 13
      tput blink;echo -e "---SECOND PLAYER BOT WINS---\n"
      tput sgr0
      return
     fi
     sleep 1.7
    fi
  done
}
multiplayer()
{    clear
      echo -n "Enter FIRST PLAYER name: "
      read first
      while ((1)); do
      echo -n "Enter SECOND PLAYER name: "
      read second
      if [[ "$first" == "$second" ]]; then
      echo "*** Please enter different name for Second Player ***"
      continue
      fi
      break
     done

     tput setaf 9
     tput bold
     tput blink;echo -e "\n-----GAME BEGINS-----\n";tput sgr0
     player1=1; player2=1
     tput setaf 3
     echo "FIRST PLAYER $first START POSITION :: $player1"
     echo "SECOND PLAYER $second START POSITION :: $player2"
     tput sgr0
     echo -e "-------------------------------\n"
     sleep 3
     currplayer=-1
     dicevalue=0
     s1=r
     s2=r
     while :; do
      #first
      clear
     if [[ "$currplayer" -eq "-1" ]]; then
      clear
      bg=`tput setab 0`
      e=`tput sgr0`
      tput setaf 2
      echo "${bg}FIRST PLAYER $first :: $player1"
      echo "SECOND PLAYER $second :: $player2${e}"
      echo "-------------------------------------"
      mov
      echo "-------------------------------------"
      tput setaf 3
      
      echo "FIRST PLAYER $first TURN:"
    echo "press r to roll Dice / press [q/Q] Quit the match"
     read s2
    if [[ "$s2" == "$s1" ]]; then
     tput setaf 1
    #dicevalue=$(($(($RANDOM%6))+1))
    dicevalue=$(echo "$RANDOM%6+1" |bc)
    echo "Dice rolling..."
    sleep 1
     echo "Dice VALUE=$dicevalue"
     tput sgr0
    CalculateValue $player1 $dicevalue
    player1=$?
    sleep 1.2
    tput setaf 13;echo "FIRST PLAYER $first :: $player1*";tput sgr0
     

     
     echo "-------------------------------"
     currplayer=1
     isWin $player1
     n2=$?
     if [[ "$n2" -eq "1" ]]; then
      tput setaf 13
     tput blink;echo -e "---FIRST PLAYER $first WINS---\n"
     tput sgr0
     return
     fi
     elif [[ "$s2" == "q" || "$s2" == "Q" ]]; then
    	echo -n "Want to Quit! For YES:[y/Y],For NO:[any KEY]:"
        read w
    	if [[ "$w" == "y" || "$w" == "Y" ]]; then
    		echo "FIRST PLAYER $first Quits"
        tput setaf 2
    		tput blink;echo -e "---SECOND PLAYER $second WINS---\n"
        tput sgr0
    		break
    	else
    		echo ""
    		continue
    	fi
     else
     echo "DICE DID NOT ROLL (run again and press $s1 to roll the dice)"
     fi
     tput sgr0
     sleep 1.7
    fi
    #second
     if [[ "$currplayer" -eq "1" ]]; then
      clear
      bg=`tput setab 0`
      e=`tput sgr0`
      tput setaf 2
      echo "${bg}FIRST PLAYER $first :: $player1"
      echo "SECOND PLAYER $second :: $player2${e}"
      echo "-------------------------------------"
      mov
      echo "-------------------------------------"
      tput setaf 2
     echo "SECOND PLAYER $second TURN:"
     echo "press r to roll Dice / press [q/Q] Quit the match"
     read s2
     if [[ "$s2" == "$s1" ]]; then
      tput setaf 1
      #dicevalue=$(($(($RANDOM%6))+1))
      dicevalue=$(echo "$RANDOM%6+1" |bc)
      echo "Dice rolling...";
      sleep 1
    echo "Dice VALUE=$dicevalue"
    tput sgr0
    CalculateValue $player2 $dicevalue
     player2=$?
      #echo "FIRST PLAYER $first :: $player1"
      sleep 1.2
     tput setaf 13;echo "SECOND PLAYER $second :: $player2*";tput sgr0
     
     echo "-------------------------------"
     currplayer=-1
     isWin $player2
     n2=$?
     if [[ "$n2" -eq "1" ]]; then
      tput setaf 13
     tput blink;echo -e "---SECOND PLAYER $second WINS---\n"
     tput sgr0
     return
     fi

     elif [[ "$s2" == "q" || "$s2" == "Q" ]]; then
    	echo -n "Want to Quit! For YES:[y/Y],For NO:[any KEY]:"
         read w
    	if [[ "$w" == "y" || "$w" == "Y" ]]; then
    		echo "SECOND PLAYER $second Quits"
        tput setaf 3
    		tput blink;echo -e "---FIRST PLAYER $first WINS---\n"
        tput sgr0
    		break
    	else
    		echo ""
    		continue
    	fi
     else
     echo "DICE DID NOT ROLL (run again and press $s1 to roll the dice)"
     fi
     tput sgr0
     sleep 1.7
     fi
     
     done
}
snake1()
{    
	    tput setaf 4
  if [[ "$1" -eq "99" ]]; then
    sleep 1
      echo "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"
      echo "|~~~~~~@ Swallowed by snake: From $1 to 54 @~~~~~~|"
      echo "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"
      player=54
      
  elif [[ "$1" -eq "70" ]]; then
    sleep 1
      echo "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"
      echo "|~~~~~~@ Swallowed by snake: From $1 to 55 @~~~~~~|"
      echo "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"
       player=55
  	
  elif [[ "$1" -eq "52" ]]; then
    sleep 1
      echo "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"
      echo "|~~~~~~@ Swallowed by snake: From $1 to 42 @~~~~~~|"
      echo "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"
       player=42
  	
  elif [[ "$1" -eq "25" ]]; then
    sleep 1
  	  echo "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"
      echo "|~~~~~~@ Swallowed by snake: From $1 to 2 @~~~~~~ |"
      echo "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"
       player=2
  elif [[ "$1" -eq "95" ]]; then
    sleep 1
  	  echo "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"
      echo "|~~~~~~@ Swallowed by snake: From $1 to 72 @~~~~~~|"
      echo "|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|"
        player=72
   fi
   tput sgr0
}
ladder()

{   
    tput setaf 6
	if [[ "$1" -eq "6" ]]; then
    sleep 1
      echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      echo "|-| climb up the ladder: From $1 to 25 |-|"
      echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      player=25
  elif [[ "$1" -eq "11" ]]; then
    sleep 1
      echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      echo "|-| climb up the ladder: From $1 to 40 |-|"
      echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      player=40
  elif [[ "$1" -eq "60" ]]; then
    sleep 1
      echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      echo "|-| climb up the ladder: From $1 to 85 |-|"
      echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
       player=85
  elif [[ "$1" -eq "46" ]]; then
    sleep 1
      echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      echo "|-| climb up the ladder: From $1 to 90 |-|"
      echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
       player=90
  elif [[ "$1" -eq "17" ]]; then
    sleep 1
      echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      echo "|-| climb up the ladder: From $1 to 69 |-|"
      echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
       player=69
  fi
  tput sgr0
}
CalculateValue()
{   

	player=$1
	player=$(echo "$player+$dicevalue" |bc)
	if [[ "$player" -gt "$WinPoint" ]]; then
		player=$(echo "$player-$2" |bc)
		return $player
	fi
	snake1 $player
	ladder $player
	return $player
}
isWin()
{
   if [[ "$WinPoint" -eq "$1" ]]; then
   	 return 1
   	else
   		return 0
   fi
}
mov()
{ tput setab 0
  tput setaf 3
  printf "| 1=START        | 100=END       |\n"
  printf "| 6=LADDER to 25 | 25=SNAKE to  2|\n"
  printf "|11=LADDER to 40 | 52=SNAKE to 42|\n"
  printf "|17=LADDER to 69 | 70=SNAKE to 55|\n"
  printf "|46=LADDER to 90 | 95=SNAKE to 72|\n"
  printf "|60=LADDER to 85 | 99=SNAKE to 54|\n"
  tput sgr0
  return
}
## MAIN
startgame

