// SPDX-License-Identifier: UNLICENCED
pragma solidity ^0.8.5;

contract Event {

    address public organizer;

    constructor() {
        organizer = msg.sender;
    }

    modifier onlyOrganizer {
        require(organizer == msg.sender,"you are not organizer.");
        _;
    }

    struct Evnt {
        string EventName;
        uint date;
        uint totalTickets;
        uint ticketsRemain;
        uint price;
    }

    mapping(uint => Evnt) public events;
    mapping(address => mapping(uint => uint)) public tickets;
    uint public eventId;

    function createEvent(string memory EventName, uint date, uint totalTickets, uint ticketsRemain, uint price) public {
        require(date>block.timestamp, "you can organize event for future date.");
        events[eventId] = Evnt(EventName, date, totalTickets, ticketsRemain, price);
        eventId++;
    }

    function buyTickets(uint id, uint quantity) public payable {
        require(events[id].date !=0, "Event does not exist.");
        require(events[id].date>block.timestamp, "Event has already occured.");
        tickets[msg.sender] [id] +=quantity;
    }

    function transferTickets(uint id, uint quantity, address transferTo) public {
         require(events[id].date !=0, "Event does not exist.");
         require(events[id].date>block.timestamp, "Event has already occured.");
        tickets[msg.sender][id] -=quantity;
        tickets[transferTo][id] +=quantity;
    }
}