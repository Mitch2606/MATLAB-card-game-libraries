function [decks] = initializeDecks(numDecks, varargin)
% Header:
%   [decks] = initializeDecks(numDecks, varargin)
%
% Use:
%   Puts the discarded cards back in the (deck)
%
% Parameters:
%   numDecks = the total number of deck variables being added to the list
%           of (numDecks)
%
% Optional Parms:
%   includeJokers = boolean for adding jokers to deck
%
%   numSuits = number of unique suits
%
%   numInSuit = number of cards in each suit, non-inclusive of jokers
%
%   suitNames = [1 X numSuits] cell array of the names of each suit
%
% Written by,
%   Mitchell Wilson; email = mitchell.wilson2606@live.com

includeJokers = 0;
numSuits = 4;
numInSuit = 13;
suitNames = [{"hearts"}, {"spades"}, {"diamonds"}, {"puppy feet"}, {"blorbos"},...
             {"problamatic faves"}];

for entry = 1:2: length(varargin)
    parm = lower(varargin{entry});
    value = varargin{entry + 1};
    
    switch(parm)
        case("includejokers")
            includeJokers = value;
        case("numsuits")
            numSuits = value;
        case("numinsuit")
            numInSuit = value;
        otherwise
            disp("Error->Initialize Deck->ParmNotFound: " + parm);
    end
end

decks = cell(4, numDecks);
for deckNum = 1:numDecks
    % initialize a empty deck
    deck = cell(2, numSuits);
    for suit = 1: numSuits
        % Jokers are numInSuit + 1
        deck{1, suit} = {suitNames{suit}};
        if(includeJokers)
            deck{2, suit} = {[1:numInSuit + 1]};
        else
            deck{2, suit} = {[1:numInSuit]};
        end
    end
    % Add deck to the list of decks
    decks{1, deckNum} = {deck};
    decks{2, deckNum} = {[1:(length(deck{2,1}{1}) * numSuits)]};
    decks{3, deckNum} = {zeros(numSuits, length(deck{2,1}{1}))};
    decks{4, deckNum} = {zeros(numSuits, length(deck{2,1}{1}))};
end




