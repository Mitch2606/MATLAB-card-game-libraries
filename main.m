% Go fish

% Initialize decks
% decks{1} = cards currently in deck
% decks{2} = order of cards to be drawn
% decks{3} = out of play cards
% decks{4} = discarded cards
decks = shuffleDecks(initializeDecks(input("How many decks? "), "includeJokers", 1));
% decks = (initializeDecks(input("How many decks? "), "includeJokers", 1));

% Get some relavent information:
suits = decks{1,1}{1}(1, :);
numSuits = length(suits);

% initialize hands
numPlayers = input("How many players? ");

playerHands = cell(1, numPlayers);
playerChoices = cell(1, numPlayers);
deckNum = 1;
numStartingCards = 5;

for player = 1: numPlayers
    playerChoices{player} = 0;
    [newCards, deck] = drawCards(decks(:, deckNum), numStartingCards);
    decks(:, deckNum) = deck;

    % Check if the deck was empty when trying to draw new cards
    if(~isempty(newCards))
        playerHand = addCardsToHand(playerHands{player}, newCards, length(deck{1,1}{1}));
        playerHands{player} = playerHand;
    else
        disp("Deck Empty");
    end
end

gameOver = 0;
turn = 1;
while (~gameOver)
    
    [gameOver, winner, playerHands, deck, turn] = goFishRulesCheck(playerHands, decks(:, deckNum), turn);
    
    decks(:, deckNum) = deck;
    
    if(turn > length(playerHands))
        turn = 1;
    end

end

disp("Congrats!! Player " + winner + " is the winner!!");












