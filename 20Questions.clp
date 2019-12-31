/*
* Alex Yu
* October 19, 2018
*
* This module plays a game of 20 Questions with the user. To use, simply batch in, think
* of animal, and play. Once batched, the game can be replayed simply through the command 
* (guessingGame).
*/

(clear)
(reset)

(defglobal ?*QUESTION_LIMIT* = 20)

(defglobal ?*questions* = 1)        ; the current question number

/********************************
*
* Animal guessing rules:
* Guess the user's chosen animal and check if the guess is correct.
*
*/

(defrule mouse
   (mammal yes)
   (fly no)
   (smallerHand yes)
   =>
   (checkIfCorrect "mouse")
)

(defrule cow
   (mammal yes)
   (biggerHuman yes | maybe)
   (farm yes)
   =>
   (checkIfCorrect "cow")
)

(defrule cat
   (mammal yes)
   (popularPet yes)
   (bark no)
   =>
   (checkIfCorrect "cat")
)

(defrule dog
   (mammal yes)
   (popularPet yes)
   (bark yes)
   =>
   (checkIfCorrect "dog")
)

(defrule bat
   (mammal yes)
   (fly yes)
   (tail no)
   =>
   (checkIfCorrect "bat")
)

(defrule flyingSquirrel
   (mammal yes)
   (fly yes)
   (tail yes)
   =>
   (checkIfCorrect "flying squirrel")
)

(defrule gorilla
   (mammal yes)
   (biggerHuman yes)
   (tail no)
   =>
   (checkIfCorrect "gorilla")
)

(defrule human
   (mammal yes)
   (biggerHuman maybe)
   (tail no)
   =>
   (checkIfCorrect "human")
)

(defrule eagle
   (bird yes)
   (fly yes)
   (carnivore yes)
   =>
   (checkIfCorrect "eagle")
)

(defrule penguin
   (bird yes)
   (fly no)
   (land maybe | no)
   (water maybe | no)
   =>
   (checkIfCorrect "penguin")
)

(defrule polarbear
   (mammal yes)
   (cold yes)
   (bear yes)
   (solidcolored yes)
   =>
   (checkIfCorrect "polar bear")
)

(defrule panda
   (mammal yes)
   (solidcolored no)
   (bear yes | maybe)
   =>
   (checkIfCorrect "panda")
)

(defrule grizzlybear
   (mammal yes)
   (cold maybe | no)
   (bear yes)
   (solidcolored yes)
   =>
   (checkIfCorrect "grizzly bear")
)

(defrule lion
   (mammal yes)
   (africa yes)
   (solidcolored yes)
   (mane yes)
   =>
   (checkIfCorrect "lion")
)

(defrule elephant
   (mammal yes)
   (africa yes)
   (solidcolored yes)
   (mane no)
   =>
   (checkIfCorrect "elephant")
)

(defrule zebra
   (mammal yes)
   (africa yes)
   (solidcolored no)
   (striped yes)
   =>
   (checkIfCorrect "zebra")
)

(defrule giraffe
   (mammal yes)
   (africa yes)
   (carnivore no)
   (solidcolored no)
   (striped no)
   =>
   (checkIfCorrect "giraffe")
)

(defrule cheetah
   (mammal yes)
   (africa yes)
   (carnivore yes)
   (solidcolored no)
   (striped no)
   =>
   (checkIfCorrect "cheetah")
)

(defrule whale
   (mammal yes)
   (biggerHuman yes)
   (ocean yes)
   =>
   (checkIfCorrect "whale")
)

(defrule dolphin
   (mammal yes)
   (biggerHuman maybe)
   (ocean yes)
   =>
   (checkIfCorrect "dolphin")
)

(defrule chicken
   (bird yes)
   (farm yes)
   =>
   (checkIfCorrect "chicken")
)

(defrule fish
   (fins yes)
   =>
   (checkIfCorrect "fish")
)

(defrule squid
   (tentacles yes)
   (ink yes | maybe)
   (pointedHead yes | maybe)
   =>
   (checkIfCorrect "squid")
)

(defrule octopus
   (tentacles yes)
   (ink yes | maybe)
   (pointedHead no)
   =>
   (checkIfCorrect "octopus")
)

(defrule jellyfish
   (tentacles yes)
   (ink no)
   =>
   (checkIfCorrect "jellyfish")
)

(defrule snake
   (reptile yes)
   (legs no)
   =>
   (checkIfCorrect "snake")
)

(defrule lizard
   (reptile yes)
   (legs yes)
   (shell no)
   =>
   (checkIfCorrect "lizard")
)

(defrule tortoise
   (reptile yes)
   (shell yes)
   (legs yes)
   (land yes)
   =>
   (checkIfCorrect "tortoise")
)

(defrule turtle
   (reptile yes)
   (shell yes)
   (legs yes)
   (land no | maybe)
   =>
   (checkIfCorrect "turtle")
)

(defrule frog
   (amphibian yes)
   (roughSkin no)
   (tail no)
   =>
   (checkIfCorrect "frog")
)

(defrule salamander
   (amphibian yes)
   (roughSkin no)
   (tail yes)
   =>
   (checkIfCorrect "salamander")
)

(defrule toad
   (amphibian yes)
   (roughSkin yes | maybe)
   =>
   (checkIfCorrect "toad")
)

/********************************
*
* Characteristic-asking rules:
* Ask the user if the user's animal has a certain characteristic and assert appropriate facts.
*
*/

(defrule askMammalAndLand
   =>
   (assert (mammal (isit "a mammal")))
   (assert (land (doesit "live primarily on land")))
)

(defrule askNativeAfrica
   (land yes)
   (cold no)
   (biggerHuman maybe | yes)
   (mammal yes)
   =>
   (assert (africa (isit "a common animal native to Africa")))
)

(defrule askSolidColored
   (or (africa yes) (bear yes))
   =>
   (assert (solidcolored (isit "solid-colored")))
)

(defrule askStriped
   (solidcolored no)
   (africa yes)
   =>
   (assert (striped (isit "striped")))
)

(defrule askIsBear
   (mammal yes)
   (land yes)
   (africa no)
   (biggerHuman yes)
   =>
   (assert (bear (isit "a type of bear")))
)

(defrule askPopularPet
   (mammal yes)
   (biggerHuman no)
   =>
   (assert (popularPet (isit "one of the most popular household pets")))
)

(defrule askBark
   (popularPet yes)
   =>
   (assert (bark (doesit "bark")))
)

(defrule askMane
   (solidcolored yes)
   =>
   (assert (mane (doesit "have a mane")))
)

(defrule askWater
   (land maybe | no)
   =>
   (assert (water (doesit "live primarily in water")))
)

(defrule askOcean
   (land maybe | no)
   (water yes)
   =>
   (assert (ocean (doesit "live primarily in the ocean")))
)

(defrule askFins
   (ocean yes)
   =>
   (assert (fins (doesit "have fins")))
)

(defrule askTentacles
   (ocean yes)
   (fins no)
   =>
   (assert (tentacles (doesit "have tentacles")))
)

(defrule askPointedHead
   (tentacles yes)
   (ink yes | maybe)
   =>
   (assert (pointedHead (doesit "have a pointed head")))
)

(defrule askInk
   (tentacles yes)
   =>
   (assert (ink (doesit "shoot ink")))
)

(defrule askBird
   (mammal no)
   =>
   (assert (bird (isit "a bird")))
)

(defrule askBiggerThanHuman
   (mammal yes)
   =>
   (assert (biggerHuman (isit "bigger than a human")))
)

(defrule askSmallerThanHand
   (biggerHuman no)
   =>
   (assert (smallerHand (isit "smaller than a human hand")))
)

(defrule askFly
   (or (bird yes) (and (mammal yes) (smallerHand maybe | no)))
   =>
   (assert (fly (doesit "fly")))
)

(defrule askCarnivore
   (land yes)
   (or (mammal yes) (bird yes))
   =>
   (assert (carnivore (isit "a carnivore")))
)

(defrule askLiveInCold
   (mammal yes)
   =>
   (assert (cold (doesit "typically live in very cold climates")))
)

(defrule askFarm
   (or (mammal yes) (bird yes))
   (land yes)
   =>
   (assert (farm (isit "a common farm animal")))
)

(defrule askReptile
   (mammal no)
   (bird no)
   =>
   (assert (reptile (isit "a reptile")))
)

(defrule askLegs
   (reptile yes)
   =>
   (assert (legs (doesit "have legs")))
)

(defrule askShell
   (reptile yes)
   =>
   (assert (shell (doesit "have a shell")))
)

(defrule askAmphibian
   (mammal no)
   (bird no)
   (reptile no)
   (land yes | maybe)
   =>
   (assert (amphibian (isit "an amphibian")))
)

(defrule askRoughSkin
   (amphibian yes)
   =>
   (assert (roughSkin (doesit "have rough skin")))
)

(defrule askTail
   (mammal yes)
   =>
   (assert (tail (doesit "have a tail")))
)

/********************************
*
* Game rules:
* End the game and prints out messages depending on whether the program won or lost the game.
*
*/

/*
* Prints out the game losing message and ends the game. Runs when the user has said that the program
* guessed the wrong animal.
*/
(defrule lostGame
   (lost)
   =>
   (printout t "Oh no, you won! I coudln't guess your animal. :( " crlf)
   (halt)
)

/*
* Prints out that the module has run out of ideas for animal guesses and asserts a fact that represents that
* the game has been lost. Runs when there are no more rules left to fire, meaning that no animals match
* the user's input.
*/
(defrule deadEnd
   (declare (salience -100))
   =>
   (printout t "Aww, I ran out of ideas." crlf)
   (assert (lost))
)

/*
* Prints out the game winning message and ends the game. Runs when the user has said that the program
* guessed the right animal.
*/
(defrule wonGame
   (won)
   =>
   (printout t "I WON! YOU LOSE!"  crlf)
   (halt)
)

/********************************
*
* Functions
*
*/

/*
* Asks the user a question starting with "Is it " given a prompt. Consequently
* returns the user's response.
* @param ?prompt the prompt to ask the user
* @return the user's response
*/
(deffunction isit (?prompt)

   (printQuestionAsked)
   (bind ?*questions* (++ ?*questions*))
   (bind ?response (askPrefix "Is it " ?prompt))
   (while (not (isValidResponse ?response))
      (bind ?response (askPrefix "Is it " ?prompt))
   )

   (checkLost)

   (return (convertResponse ?response))

) ; (deffunction isit (?prompt)

/*
* Asks the user a question starting with "Does it " given a prompt. Consequently
* returns the user's response.
* @param ?prompt the prompt to ask the user
* @return the user's response
*/
(deffunction doesit (?prompt)

   (printQuestionAsked)
   (bind ?*questions* (++ ?*questions*))
   (bind ?response (askPrefix "Does it " ?prompt))
   (while (not (isValidResponse ?response))
      (bind ?response (askPrefix "Does it " ?prompt))
   )

   (checkLost)

   (return (convertResponse ?response))

) ; (deffunction doesit (?prompt)

/*
* Prints the question number that the program is currently on.
*/
(deffunction printQuestionAsked ()

   (printout t crlf "Question " ?*questions* crlf)
   (return)

)

/*
* Prompts the user if the program has guessed the right animal. Either way, the program ends here. If
* the program is right, then this function asserts a fact representing that it has won. Otherwise, 
* it asserts a fact representing that it has lost.
*/
(deffunction checkIfCorrect (?animal)

   (bind ?response (isit (str-cat "a " ?animal)))

   (if (= (convertResponse ?response) "yes") then
      (assert (won))
    else
      (assert (lost))
   )

   (return)

) ; (deffunction checkIfCorrect (?animal)

/*
* Checks if the program has lost by going over the question limit. If so, asserts a fact that
* represents that the game has been lost. Otherwise, this function does nothing.
*/
(deffunction checkLost ()
   (if (>= ?*questions* ?*QUESTION_LIMIT*) then
      (assert (lost))
   )

   (return)
)

/*
* Prompts user with a given prefix for a question and the given unknown and returns his/her answer.
* @param ?prefix  the question to prompt the user
* @param ?prompt  the unknown in the question
* @return the user's answer
*/
(deffunction askPrefix (?prefix ?prompt)
   (bind ?newPrompt (str-cat ?prefix ?prompt))
   (return (ask ?newPrompt))
)

/*
* Prompts user with a given question and returns his/her answer.
* @param ?prompt  the question to prompt the user
* @return the user's answer
*/
(deffunction ask (?prompt)
   (printout t ?prompt "? ")
   (bind ?response (read))
   (return ?response)
)

/*
* Checks to see that the user has entered a y, n, or ? as input for yes, no, or maybe.
* @param ?response   the user's response
* @return true       if the user has entered a y, n, or ?; otherwise,
*         false
*/
(deffunction isValidResponse (?response)

   (bind ?input (lowcase (sub-string 1 1 ?response)))

   (if (or (= ?input "y") (= ?input "n") (= ?input "?")) then
      (bind ?x TRUE)
   else
      (bind ?x FALSE)
   )

   (return ?x)

) ; (deffunction isValidResponse (?response)

/*
* Converts a given response to yes, no, or maybe based on the first character of the input string.
* @param ?response   the user's response
* @return the converted response
*/
(deffunction convertResponse (?response)

   (bind ?input (lowcase (sub-string 1 1 ?response)))

   (if (= ?input "y") then
      (bind ?input yes)
   elif (= ?input "n") then
      (bind ?input no)
   elif (= ?input "?") then
      (bind ?input maybe)
   )

   (return ?input)
) ; (deffunction convertResponse (?response)

/*
* Prints a formatted message that introduces the program and gives the user instructions on 
* how to answer the questions.
*/
(deffunction startupMsg ()

   (printout t crlf)
   (printout t "************************ ANIMAL GUESSING GAME ************************" crlf)
   (printout t "* Think of an animal, and I will ask a series of questions that will *" crlf)
   (printout t "* help me determine what animal you are thinking of. For each        *" crlf)
   (printout t "* question, answer y for yes, n for no, and ? for maybe.             *" crlf)
   (printout t "**********************************************************************" crlf)

   (return)

)

/*
* Starts the game.
*/
(deffunction guessingGame ()

   (startupMsg)

   (run)

   (reset)
   (return)

)

(guessingGame)