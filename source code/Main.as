package
{
	import adobe.utils.CustomActions;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import Math;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	/**
	 * ...
	 * @author 
	 */
	
	[SWF(width="550", height="550", backgroundColour="#FFFFFF", frameRate="60")]
	public class Main extends Sprite 
	{
		
		public const ROCK:int = 1;
		public const PAPER:int = 2;
		public const SCISSORS:int = 3;
		public const MAGNET:int = 4;
		
		public const WIN:int = 1;
		public const LOSE:int = 2;
		public const DRAW:int = 3;
		public const STREAK:int = 4;
		
		
		[Embed(source = "../img/win.png")]
		public var WinButton:Class;
		public var winButton:DisplayObject = new WinButton();
		
		
		[Embed(source = "../img/lose.png")]
		public var LoseButton:Class;
		public var loseButton:DisplayObject = new LoseButton();
		
		[Embed(source = "../img/draw.png")]
		public var DrawButton:Class;
		public var drawButton:DisplayObject = new DrawButton();
		
		[Embed(source = "../img/magnet.png")]
		public var MagnetButton:Class;
		public var aiMagnet:DisplayObject = new MagnetButton();
		
		public var outcomeButton:Sprite = new Sprite();
		
		[Embed(source = "../img/paper.png")]
		public var PaperButton:Class;
		public var paperButtonImg:DisplayObject = new PaperButton();
		public var paperButton:Sprite = new Sprite();
		public var aiPaper:DisplayObject = new PaperButton();
		public var playerPaper:DisplayObject = new PaperButton();
		
		[Embed(source = "../img/scissors.png")]
		public var ScissorsButton:Class;
		public var scissorsButtonImg:DisplayObject = new ScissorsButton();
		public var scissorsButton:Sprite = new Sprite();
		public var aiScissors:DisplayObject = new ScissorsButton();
		public var playerScissors:DisplayObject = new ScissorsButton();
		
		[Embed(source = "../img/rock.png")]
		public var RockButton:Class;
		public var rockButtonImg:DisplayObject = new RockButton();
		public var rockButton:Sprite = new Sprite();
		public var aiRock:DisplayObject = new RockButton();
		public var playerRock:DisplayObject = new RockButton();
		
		public var aiButton:Sprite = new Sprite();
		public var playerMoveButton:Sprite = new Sprite();
		
		[Embed(source = "../img/button.png")]
		public var ContinueButton:Class;
		public var continueButtonImg:DisplayObject = new ContinueButton();
		public var continueButton:Sprite = new Sprite();
		
		public var contButtonImg2:DisplayObject = new ContinueButton();
		public var contButton2:Sprite = new Sprite();
		
		[Embed(source = "../img/skip.png")]
		public var SkipButton:Class;
		public var skipButtonImg:DisplayObject = new SkipButton();
		public var skipButton:Sprite = new Sprite();
		
		[Embed(source = "../img/error.png")]
		public var ErrorMessage:Class;
		public var errorMessage:DisplayObject = new ErrorMessage();
		
		public var playerHistory:Array = new Array();
		public var aiHistory:Array = new Array();
		public var winHistory:Array = new Array();
		
		public var winStreak:int;
		public var curr_level:int = 0;
		
		public var winTally:Tally; 
		public var loseTally:Tally;
		public var drawTally:Tally;
		public var streakTally:Tally = new Tally(STREAK);
		
		public var transScreen:TransitionScreen;
		
		public var yourMoveLabel:MyText = new MyText(5, "Your move:");
		public var aiMoveLabel:MyText = new MyText(5, "Computer's move:");
		
		public var n:int = 0;
		public var err:int = 20;
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			winStreak = 0;
			addButtons();
			setTallies();
			
			
			
			nextLevel();
			
		}
		
		public function decreaseStreak():void
		{
			winStreak -= 2;
			if (winStreak < 0) winStreak = 0;
			stage.removeChild(streakTally);
			streakTally = new Tally(STREAK);
			streakTally.x = 50;
			streakTally.y = 200;
			stage.addChild(streakTally);
			var i:int;
			for (i = 1; i <= winStreak; i++)
			{
				streakTally.addDot();
			}
		}
		
		public function clearStreak():void
		{
			winStreak = 0;
			stage.removeChild(streakTally);
			streakTally = new Tally(STREAK);
			streakTally.x = 50;
			streakTally.y = 200;
			stage.addChild(streakTally);
		}
		public function setTallies():void
		{
			winTally = new Tally(WIN);
			winTally.x = 50;
			winTally.y = 50;
			stage.addChild(winTally);
			
			loseTally = new Tally(LOSE);
			loseTally.x = 400;
			loseTally.y = 50;
			stage.addChild(loseTally);
			
			drawTally = new Tally(DRAW);
			drawTally.x = 400;
			drawTally.y = 200;
			stage.addChild(drawTally);
			
			streakTally = new Tally(STREAK);
			streakTally.x = 50;
			streakTally.y = 200;
			stage.addChild(streakTally);
			
		}
		public function clearTallies():void
		{
			stage.removeChild(winTally);
			stage.removeChild(loseTally);
			stage.removeChild(drawTally);
			stage.removeChild(streakTally);
			setTallies();
		}
		
		
		public function addButtons():void
		{
			
			rockButton.addChild(rockButtonImg);
			scissorsButton.addChild(scissorsButtonImg);
			paperButton.addChild(paperButtonImg);
			
			aiButton.addChild(aiPaper);
			aiButton.addChild(aiRock);
			aiButton.addChild(aiScissors);	
			aiButton.addChild(aiMagnet);
			
			//playerMoveButton.addChild(rockButtonImg);
			//stage.addChild(playerMoveButton);
			
			outcomeButton.addChild(winButton);
			outcomeButton.addChild(loseButton);
			outcomeButton.addChild(drawButton);
			stage.addChild(outcomeButton);
			
			stage.addChild(aiButton);
			
			stage.addChild(rockButton);
			stage.addChild(scissorsButton);
			stage.addChild(paperButton);
			
			continueButton.addChild(continueButtonImg);
			stage.addChild(continueButton);
			continueButton.visible = false;
			
			playerMoveButton.addChild(playerRock);
			playerMoveButton.addChild(playerScissors);
			playerMoveButton.addChild(playerPaper);
			
			stage.addChild(playerMoveButton);
			
			var gap:int = 5;
			
			rockButton.x = stage.stageWidth / 2 - rockButton.width / 2;
			rockButton.y = stage.stageHeight - 3 * rockButton.height;
			
			scissorsButton.x = rockButton.x - (scissorsButton.width/2 + gap/2);
			scissorsButton.y = rockButton.y + (rockButton.height + gap);
			scissorsButton.visible = true;
		
			paperButton.x = scissorsButton.x + scissorsButton.width + gap;
			paperButton.y = scissorsButton.y;
			
			contButton2.x = continueButton.x = rockButton.x;
			contButton2.y = continueButton.y = rockButton.y;
			
			
			
			
			outcomeButton.x = continueButton.x + continueButton.width / 2 - winButton.width / 2;
			outcomeButton.y = 200;//(playerMoveButton.y + aiButton.y) / 2 + 50;
			
			rockButton.addEventListener(MouseEvent.CLICK, playRock);
			paperButton.addEventListener(MouseEvent.CLICK, playPaper);
			scissorsButton.addEventListener(MouseEvent.CLICK, playScissors);
			
			continueButton.addEventListener(MouseEvent.CLICK, continuef);
			
			aiButton.x = rockButton.x;
			//aiRock.x = aiPaper.x = aiScissors.x = rockButton.x;
			aiButton.y = outcomeButton.y - aiButton.height - 4 * gap;
			playerMoveButton.x = rockButton.x;
			playerMoveButton.y =  outcomeButton.y +outcomeButton.height + 4 * gap;
			
			
			aiMagnet.visible = aiRock.visible = aiPaper.visible = aiScissors.visible = false;
			playerRock.visible = playerPaper.visible = playerScissors.visible = false;
			winButton.visible = loseButton.visible = drawButton.visible = false;
			
			skipButton.addChild(skipButtonImg);
			skipButton.x = stage.stageWidth - skipButton.width;
			skipButton.y = stage.stageHeight - skipButton.height;
			stage.addChild(skipButton);
			skipButton.addEventListener(MouseEvent.CLICK, nextLevel);
			
			
			//stage.addChild(yourMove);
			playerMoveButton.addChild(yourMoveLabel);
			yourMoveLabel.y =  - yourMoveLabel.height;
			yourMoveLabel.visible = false;
			
			aiButton.addChild(aiMoveLabel);
			
			aiMoveLabel.y =  - aiMoveLabel.height;
			aiMoveLabel.visible = false;
			}
		
		public function continuef(e:Event):void
		{
			winButton.visible = loseButton.visible = drawButton.visible = false;
			aiRock.visible = aiPaper.visible = aiScissors.visible = false;
			playerRock.visible = playerPaper.visible = playerScissors.visible = false;
			continueButton.visible = false;
			rockButton.visible = paperButton.visible = scissorsButton.visible = true;
			yourMoveLabel.visible = false;
			aiMoveLabel.visible = false;
		}
		
		
		
		public function playRock(e:Event):void
		{
			playerRock.visible = true;
			playerMove(ROCK);
			
			
		}
		public function playPaper(e:MouseEvent):void
		{
			playerPaper.visible = true;
			playerMove(PAPER);
		}
		public function playScissors(e:MouseEvent):void
		{
			playerScissors.visible = true;
			playerMove(SCISSORS);
		}
		
		public function playerMove(play:int):void
		{
			rockButton.visible = paperButton.visible = scissorsButton.visible = false;
			yourMoveLabel.visible = true;
			aiMoveLabel.visible = true;
			var aiMove:int;
			
			aiMove = chooseplay(curr_level);
			
			aiPlay(aiMove);
			
			var outcome:int;
			aiHistory.unshift(aiMove);
			playerHistory.unshift(play);
			outcome = checkWinner(play, aiMove);
			winHistory.unshift(outcome);
			if (outcome == WIN) playerWin();
			if (outcome == LOSE) playerLose();
			if (outcome == DRAW) playerDraw();
			
			if (curr_level!=8) continueButton.visible = true;
			
			//stage.addChild(new MyText(6, String(play), n));
			//stage.addChild(new MyText(7, String(outcome), n));
			//n += 10; 
			
		}
		
		
		
		
		
		public function nextLevel(e:Event = null):void
		{
			clearStreak();
			clearTallies();
			curr_level++;
			skipButton.visible = false;
			transScreen= new TransitionScreen(curr_level);
			stage.addChild(transScreen);
			
			stage.addEventListener(Event.ENTER_FRAME, check_open_trans);
			
			
			
			
			
		}
		
		public function check_open_trans(e:Event):void
		{
			if (transScreen.opened)
			{
				stage.removeEventListener(Event.ENTER_FRAME, check_open_trans);
				contButton2.addChild(contButtonImg2);
				stage.addChild(contButton2);
				contButton2.addEventListener(MouseEvent.CLICK, continue_trans);
			}
		}
		
		public function continue_trans(e:Event):void
		{
			contButton2.removeEventListener(MouseEvent.CLICK, continue_trans);
			stage.removeChild(contButton2);
			transScreen.close();
			continuef(null);
			skipButton.visible = true;
		}
		
		public function playerWin():void
		{
			winStreak++;
			winButton.visible = true;
			winTally.addDot();
			streakTally.addDot();
			if (winStreak == 6)
			{
				nextLevel();
			}
			
		}
		
		public function playerLose():void
		{
			
			loseButton.visible = true;

			decreaseStreak();
			loseTally.addDot();
			
			
		}
		public function playerDraw():void
		{
			drawButton.visible = true;
			drawTally.addDot();
			
		}
		
		public function aiPlay(move:int):void
		{
			if (move == ROCK) aiRock.visible = true;			
			if (move == PAPER) aiPaper.visible = true;			
			if (move == SCISSORS) aiScissors.visible = true;
			if (move == MAGNET)
			{
				aiMagnet.visible = true;
				playMagnet();
			}
			
		}
		
		public function playMagnet():void
		{
			var timer:Timer = new Timer(3000);
			timer.addEventListener(TimerEvent.TIMER, displayMagnetMessage);
			timer.start();
			stage.removeChild(skipButton);
			
			
		}
		public function displayMagnetMessage(e:Event):void
		{
			
			stage.addChild(errorMessage);
			
			
		}
		
		public function chooseplay(level:int):int
		{	//see if there is a queue function/data structure. Can I make my own if not?
			
			if (level == 0) return ((Math.random()*10) % 3) + 1;
			
			//DOUG
			if (level == 1) return ROCK; //play rock every time
			
			//KATERINA
			if (level == 2) 
			{	//play whatever you played last turn 
				
				if (playerHistory.length == 0) return ROCK;
				return playerHistory[0];
			}
			
			//BETTERINA
			if (level == 3) 
			{	//play whatever would have beaten the player last turn 
				if (playerHistory.length == 0) return ROCK;
				return beats(playerHistory[0]);
			}
			
			
			//JOHNO SMITHO
			if (level == 4)
			{	//stays the same if won last round, 
				//changes to the one that would have beat the player's if lost last round
				//if draw, stay the same, unless drawed twice in a row, in which case switch to what beats the draw
				
				
				
				if (playerHistory.length == 0) return ROCK;
				
				var lastRoundOutcome:int = checkWinner(aiHistory[0], playerHistory[0]);
				var secondLastRoundOutcome:int;
				
				if (playerHistory.length == 1) secondLastRoundOutcome = WIN;
				else secondLastRoundOutcome= checkWinner(aiHistory[1], playerHistory[1]); 		
				
				
				if (lastRoundOutcome == DRAW)
				{
					if (secondLastRoundOutcome == DRAW) return beats(aiHistory[0]);
					else return aiHistory[0];
					
				}
				
				if (lastRoundOutcome == WIN) return aiHistory[0];
				
				if (lastRoundOutcome == LOSE) return beats(playerHistory[0]);
				
			}
			
			var i:int;
				
			var play:int = ROCK;
			var hist:int;
			
			//PATTY
			if (level == 5)
			{
				//pattern matching. looks for the small repeats (up to 5 moves long) in payer history 
				//to predict what the player will do next
				
				//should we look at whether what happened next succeeded? YES. 
				
				for (i = 1; i <= 5; i++)
				{
					
					hist = patternMatch(playerHistory, i);
					if (hist != -1)
					{
						
						if (checkWinner(playerHistory[hist], aiHistory[hist]))
						{	//if they won last time, they may repeat the move.
							play = beats(playerHistory[hist]);
						}
						
						else
						{
							//if not, maybe they rememeber what you did
							play = beats(beats(playerHistory[hist]));
						}
						
						
					}
					else break;
				}
				
				return play;
			}
			
			//SQUINT
			if (level == 6)
			{
				
				//pattern matching 2: meta patterns
				//instead of looking for patterns in moves, looks for patterns in 
				//win/lose/draw. 
				//to predict what the player wil do next
				//WITHOUT looking at whatever happened next succeeded
				
				play = ROCK;
				for (i = 1; i <= 5; i++)
				{
					
					hist = patternMatch(winHistory, i);
					if (hist != -1)
					{
						
						if (playerHistory[hist] == playerHistory[hist + 1])
						{
							play = playerHistory[0];
						}
						
						else if (playerHistory[hist] == beats(playerHistory[hist + 1]))
						{
							play = beats(playerHistory[0]);
						}
						else play = beats(beats(playerHistory[0]));
					}
					else break;
				}
				return play;
			}
			
			//THE ORACLE
			if (level == 7)
			{	
				play = metaPattern(playerHistory, winHistory);
				if (play == -1) play = ROCK;
				return play; 
				
			}
			
			//BEEP BOOP
			if (level == 8)
			{	
				return MAGNET;
				
			}
			return -1;
			
		}
		
		public function patternMatch(list:Array, len:int):int
		{
			//matches the last len elements to their most recent appearence
			//returns the index of the next play
			//-1 if no match found
			
			if (len >= list.length) return -1;
			var i:int;
			var j:int;
			var match:Boolean;
			for (i = 1; i < list.length - len; i++)
			{
				match = true;
				for (j = 0; j < len; j++)
				{
					if (list[j] != list[i + j]) 
					{
						match = false;
						break;
					}
				}
				if (match) return i - 1;

			}
			return -1;
		}
		
		public function patternMatch2(len:int):Array
		{
			//for each match, append the index of the next move to the restult array. 
			var result:Array = new Array();
			//var metaHistory:Array = new Array();
			if (len >= playerHistory.length) return result;
			var i:int;
			var j:int;
			var match:Boolean;
			for (i = 1; i < playerHistory.length - len; i++)
			{
				match = true;
				for (j = 0; j < len; j++)
				{
					if (playerHistory[j] != playerHistory[i + j] || winHistory[j] != winHistory[i + j]) 
					{
						match = false;
						break;
					}
				}
				if (match) result.push(i-1);

			}
			return result;
		}
		
		
		
		
		public function metaPattern(playHist_r:Array, winHist_r:Array):int
		{
			
			var newPlayHist:Array = new Array();
			var newWinHist:Array = new Array();
			
			var len:int = 1; 
			var i:int;
			var j:int;
			var match:Boolean;
			var foundOne:Boolean 
			foundOne = false;
			for (i = 1; i <= playHist_r.length - len; i++)
			{
				for (j = 0; j < len; j++)
				{
					match = true;
					
					
					if (playHist_r[i + j] != playHist_r[j] || winHist_r[i + j] != winHist_r[j])
					{
						match = false; 
					}
					
				}
				if (match)
				{
					
					//stage.addChild(new MyText(8, "found one!", n, err));
					//err += 10;
					foundOne = true;
					newPlayHist.push(playHist_r[i - 1]);
					newWinHist.push(playHist_r[i - 1]);
				}
			}
			
			if (!foundOne) {
				//stage.addChild(new MyText(8, "not found!", n, err));
				//err += 10;
				return -1;
			}
			if (newPlayHist.length == playHist_r.length)
			{
				//stage.addChild(new MyText(8, "not decreased", n, err)); 
				//err += 10;
				return -1;
			}
			var analysis:int = analyse(newWinHist); 
			if (analysis != -1) 
			{
				//stage.addChild(new MyText(8, "predict "+ String(analysis), n, err)); 
				//err += 10;
				return beats(analysis);
				
			}
			//stage.addChild(new MyText(8, "next", n, err));
			//err += 10;
			var next:int = metaPattern(newPlayHist, newWinHist);
			if (next != -1) 
			{
				
				return next;
			}
			//stage.addChild(new MyText(8, "next no good", n, err));
			//err += 10;
			return beats(newPlayHist[0]);
			
			
			
		}
		
		public function printHistory():void
		{
			var i:int = 0;
			stage.addChild(new MyText(8, "winHist: ", i*10, err));
			for (i = 0; i < winHistory.length; i++)
			{
				stage.addChild(new MyText(8, String(winHistory[i]), i*10 + 30, err));
			}
		}
		
		
		
		public function analyse(history:Array):int
		{
			//first, count how much of each following play there is. 
			var TOTAL:int = 0; 
			var count:Array = new Array();
			count[TOTAL] = count[ROCK] = count[PAPER] = count[SCISSORS] = 0;
			var i:int;
			for (i = 0; i < history.length; i++)
			{
				count[playerHistory[i]]++;
				count[TOTAL]++;
			}
			
			//if they mostly play one, 
			if ((count[ROCK] * 100) / count[TOTAL] > 90)
			{
				return (ROCK);
			}
			if ((count[PAPER] * 100) / count[TOTAL] > 90)
			{
				return (PAPER);
			}
			if ((count[SCISSORS] * 100) / count[TOTAL] > 90)
			{
				return (SCISSORS);
			}
			return -1;
			
			
			
		}
		 
		public function beats(play:int):int
		{	//returns a move to beat play
			
			if (play == ROCK) return PAPER;
			if (play == PAPER) return SCISSORS;
			if (play == SCISSORS) return ROCK;
			return -1;
		}
		
		public function checkWinner(player:int, opponent:int):int
		{	//returns whether the player won, lost, or drew
			if (player == opponent) return DRAW;
			if (player == beats(opponent)) return WIN;
			if (opponent == MAGNET) return LOSE;
			return LOSE;
			
			
		}
	}
	
	
	
}


