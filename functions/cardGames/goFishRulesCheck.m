function [gameOver, winner, playerHands, deck, turn, scores] = ...
    goFishRulesCheck(playerHands, deck, turn, scores, varargin)

numInSet = 4;
for i = 1:2: length(varargin)
    parm = lower(varargin{i});
    value = varargin{i + 1};
    switch(parm)
        case("numinset")
            numInSet = value;
        otherwise
            disp("Error->goFishRulesCheck->ParmNotFound: " + parm);
    end
end

suits = deck{1}{1}(1, :);

gotCards = 1;
while(gotCards == 1)
    displayHand(playerHands{turn}, suits)

    playerBeingAsked = input("Player " + turn + ": Who are you asking? ");
    num = input("What number are you looking for? ");
    
    gotCards = 0;
    for suit = 1: length(playerHands{playerBeingAsked})
        if(isempty(playerHands{playerBeingAsked}{suit}))
            continue;
        end

        if(sum(playerHands{playerBeingAsked}{suit}(playerHands{playerBeingAsked}{suit} == num)) > 0)
            disp("Player " + playerBeingAsked + " I have an " + num);
            playerHands = transferCard(playerHands, turn, playerBeingAsked, [suit, num]);
            
            [~, cards, playerHands{turn}] = findSet(playerHands{turn}, suits, "numInSet", numInSet);
            for suit2 = 1: size(cards, 1)
                if(isempty(cards{suit2, 1}))
                    continue;
                end

                for card = 1: length(cards{suit2, 2}{1})
                    deck{3}{1}(suit2, cards{suit2, 2}{1}(card)) = cards{suit2, 2}{1}(card); 
                end
            end

            gotCards = 1;    
        end
        
    end

     
    if(~gotCards)
        disp("Player " + playerBeingAsked + ": Go Fish!")
        [newCards, deck] = drawCards(deck, 1);
        if(~isempty(newCards))
            playerHand = addCardsToHand(playerHands{turn}, newCards, length(deck{1,1}{1}));
            playerHands{turn} = playerHand;
        end

        turn = turn + 1;


        break;
    end

end



gameOver = 0;
winner = 0;

cardsInHand = 0;
for playerNum = 1: length(playerHands)
    % Check the players' hands to see if there are cards still in play
    playerHand = playerHands{playerNum};
    for suit = 1: length(playerHand)
        if(~isempty(playerHand{suit}))
            cardsInHand = 1;
            break;
        end
    end
    
    % If there aren't cards in anyone's hands, the game is over
    if(~cardsInHand)
        gameOver = 1;
        break
    end
end

if (gameOver)
    [~, winner] = max(scores);
end

end