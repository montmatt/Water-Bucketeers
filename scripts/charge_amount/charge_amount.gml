function ChargeState(op, v) {
    static total = 0;
    switch (op) {
        case "set": total = v; break;
        case "subtract": total -= v; break;
        case "get": return total;
    }
}

function SetCharge(value) {
    ChargeState("set", value);
}

function ChangeCharge(amount) {
    ChargeState("subtract", amount);
}

function GetCharge() {
    return ChargeState("get", 0);
}