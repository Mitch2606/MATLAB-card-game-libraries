function [suitNum] = getSuitNum(suitName, suits)
%GETSUITNUM Summary of this function goes here
%   Detailed explanation goes here

suitNum = 0;
while(suitNum == 0)
    for suit = 1: length(suits)
        sameBool = strcmp(suitName, suits{suit}{1});
        if(sameBool)
            suitNum = suit;
            return
        end
    end
    
    disp("Suit: " + suitName + " not found! ")
    suitName = input("Input suit name: ", 's');
end




end

