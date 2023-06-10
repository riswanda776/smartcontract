/// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Pilpres {
    struct Capres {
        uint256 nomor;
        string name;
        uint256 age;
        string partai;
        uint256 suara;
    }

    Capres[] daftarCapres;

    address public owner;
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    mapping(address => uint256) balances;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply
    ) {
        owner = msg.sender;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply * (10**uint256(_decimals));
        balances[msg.sender] = totalSupply;
        daftarCapres.push(Capres(1, "Jokowi", 60, "PDI Perjuangan", 0));
        daftarCapres.push(Capres(2, "Ganjar", 60, "PDI Perjuangan", 0));
        daftarCapres.push(Capres(3, "Puan", 60, "PDI Perjuangan", 0));
        daftarCapres.push(Capres(4, "Megawati", 60, "PDI Perjuangan", 0));
        daftarCapres.push(Capres(5, "Aldi Taher", 60, "Nasdem", 0));
    }

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    function votingCapres(uint256 nomor) public {
        for (uint256 i = 0; i < daftarCapres.length; i++) {
            if (daftarCapres[i].nomor == nomor) {
                daftarCapres[i].suara = daftarCapres[i].suara + 1;
            }
        }

        uint256 _amount = 69 * (10**uint256(18));
        require(_amount <= balances[owner], "Insufficient balance");
        balances[owner] -= _amount;
        balances[msg.sender] += _amount;
        emit Transfer(owner, msg.sender, _amount);
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function hasilSuara() public view returns (Capres[] memory) {
        return daftarCapres;
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(to != address(0), "Invalid recipient address");
        require(value <= balances[msg.sender], "Insufficient balance");

        balances[msg.sender] -= value;
        balances[to] += value;

        emit Transfer(msg.sender, to, value);
        return true;
    }
}
