function [runBool, cards, playerHand] = findRun(playerHand, suits, varargin)
%FINDRUN Summary of this function goes here
%   Detailed explanation goes here

numInRun = 4;
for entry = 1:2: length(varargin)
    parm = lower(varargin{entry});
    value = varargin{entry + 1};
    
    switch(parm)
        case("numinrun")
            numInRun = value;
        otherwise
            disp("Error->findRun->ParmNotFound: " + parm);
    end
end

runBool = 0;
cards = [];
numSuits = size(playerHand, 2);

for suit = 1: numSuits
    % Check if suit is empty in hand
    if(isempty(playerHand{suit})) || (length(playerHand{suit}) < numInRun)
        continue;
    end

    indicesOfCards = [];
    for cardInSuit = 2: length(playerHand{suit})
        if((playerHand{suit}(cardInSuit - 1) + 1) == playerHand{suit}(cardInSuit))
            if(cardInSuit == 2)
                indicesOfCards = [indicesOfCards, cardInSuit - 1];

            end


            indicesOfCards = [indicesOfCards, cardInSuit];
        end

    end
    numInRow = length(indicesOfCards);

    % Check if there is enough in a row to do more calculations
    if(numInRow < numInRun)
        continue;
    end
    
    % See how many runs there are
    disp(suits{suit}{1} + ":")
    disp(playerHand{suit}(indicesOfCards))

    if(mod(numInRow, numInRun) == 0)
        if(numInRun == numInRow)
            removeAllBool = 1;
        else
            removeAllBool = input("Do you want to place down all avaliable cards? (1-y / 0-n)");
        end

        % Remove All if the player says yes, otherwise move to next if
        if(removeAllBool)
            cards = [cards; [{suit}, {playerHand{suit}(indicesOfCards)}]];
            continue;
        end

    end

    if(numInRow > numInRun)
        numToStart = playerHand{suit}(end);
        numOfCards = numInRun;
        
        wrong = 1;
        while(wrong >= 1)
            if(wrong >= 2)
                disp("Either choose a different starting point or number of cards! ")
            end

            numToStart = input("First number in run: ");

            numOfCards = input("Num to put down: ");
            while(numOfCards < numInRun)
                disp("Minimum Run Length is " + numInRun);
                numOfCards = input("Num to put down: ");
            end
            
            % Check if the hand contains the cards that need to be gotten
            % rid of
            if(sum(playerHand{suit}(indicesOfCards) == (numToStart + numOfCards - 1)) == 0)
                wrong = wrong + 1;
                continue;
            else
                wrong = 0;
            end

            cards = [cards; [{suit}, {[numToStart:numToStart + numOfCards - 1]}]];
            
            for iterator = numToStart: (numToStart + numOfCards - 1)
                playerHand{suit}(playerHand{suit} == iterator) = 0;
            end

            playerHand{suit} = removeZeros(playerHand{suit});
            
        end


        continue;
    end


end

end

