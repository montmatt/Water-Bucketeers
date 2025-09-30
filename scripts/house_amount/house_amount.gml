function HouseState(op, v) {
    static total = 0;
    switch (op) {
        case "set": total = v; break;
        case "subtract": total -= v; break;
        case "get": return total;
    }
	
	if(total <= 0) room_restart();
}

function SetHouse(value) {
    HouseState("set", value);
}

function ChangeHouse(amount) {
    HouseState("subtract", amount);
}

function GetHouse() {
    return HouseState("get", 0);
}