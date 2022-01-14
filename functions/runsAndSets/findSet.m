function [setBool, cards, playerHand] = findSet(playerHand, suits, varargin)
% Assign optional parmss
numInSet = 3;

for entry = 1:2: length(varargin)
    parm = lower(varargin{entry});
    value = varargin{entry + 1};

    switch(parm)
        case("numinset")
            numInSet = value;
        otherwise
            disp("Error->findSet->ParmNotFound: " + parm);
    end
end


numSuits = size(playerHand, 2);

setBool = 0;
cards = [];

maximumLength = 1;
numEmpty = 0;
for suit = 1: numSuits
    % Check now if the hand is too empty to have a set
    numEmpty = numEmpty + isempty(playerHand{suit});

    if(numEmpty > (numSuits - numInSet))
        return
    end

    % Find the maximum number of cards in each suit
    temp = length(playerHand{suit});
    if(temp > maximumLength)
        maximumLength = temp;
    end
end

% Format cards into a matrix
temp = [];
for suit = 1: numSuits
    temp2 = [playerHand{suit}, zeros(1, maximumLength - length(playerHand{suit}))];
    temp = [temp; temp2];
end

% See if there is a set
for num = temp(1, 1): length(temp(1, :))
    if(num == 0)
        break;
    end

    if(sum(find(temp' == num) >= 0) >= numInSet)
        if(isempty(cards))
            cards = cell(numSuits, 2);
        end

        setBool = 1;

        removeCardsBool = input("Want to remove all " + num + "'s from your hand? (1 - y/ 0 - n) ");

        if(~removeCardsBool)
            numRemoved = 0;
            while(numRemoved < numInSet)
                for suit = 1: numSuits
                    if(sum(playerHand{suit}(playerHand{suit} == num) > 0))
                        removeCardBool = input("Remove " + num + " of " + suits{suit}{1} + "? (1 - y/ 0 - n)" );

                        if(removeCardBool)
                            cards{suit, 1} = suit;
                            cards{suit, 2} = [cards{suit, 2}, num];

                            playerHand{suit}(playerHand{suit} == num) = 0;
                            playerHand{suit} = removeZeros(playerHand{suit});

                            numRemoved = numRemoved + 1;
                        end

                    end

                end

                if(numRemoved < numInSet)
                    disp("You have to lay down more cards!")
                end

            end
        else
            for suit = 1: numSuits
                cards{suit, 1} = suit;
                cards{suit, 2} = [cards{suit, 2}, num];

                playerHand{suit}(playerHand{suit} == num) = 0;
                playerHand{suit} = removeZeros(playerHand{suit});

                numRemoved = numRemoved + 1;

            end
        end
    end
end

end

