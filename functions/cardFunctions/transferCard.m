function playerHands = transferCard(playerHands, receiver, giver, cardInfo)
% Header:
%   playerHands = transferCard(playerHands, receiver, giver, cardInfo)
%
% Use:
%   Transfers a card define by (cardInfo) from (giver)'s hand to
%       (receiver)'s. 
%
% Parameters:
%   playerHands = [1 X numPlayers] cell array containing [1 X numSuits]
%       cell arrays containing [0-numCardsInSuit] of numbers
%
%   receiver = int index for playerHands
%   
%   giver = int index for playerHands
%
%   cardInfo = [suit, number];
%
% Optional Parms:
%   N/A
%
% Written by,
%   Mitchell Wilson; email = mitchell.wilson2606@live.com

% Define Hands
receiverHand = playerHands{receiver};
giverHand = playerHands{giver};

% Define card info
suit = cardInfo(1);
cardNum = cardInfo(2);

% Remove card from giver
giverHand{suit}(giverHand{suit} == cardNum) = 0;
giverHand{suit} = removeZeros(giverHand{suit});

playerHands{giver} = giverHand;

% Add card to receiver
receiverHand{suit} = [receiverHand{suit}, cardNum];
receiverHand{suit} = sort(receiverHand{suit});

playerHands{receiver} = receiverHand;

end

