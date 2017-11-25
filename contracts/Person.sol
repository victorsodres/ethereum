pragma solidity ^0.4.18;

contract Owner {
    address public owner;
}

contract Person is Owner {
    string public nome;
    string public cpf;
    string public dataNascimento;
    string public email;

    function Person(string _nome, string _cpf, string _dataNascimento, string _email) public {
        nome = _nome;
        cpf = _cpf;
        dataNascimento = _dataNascimento;
        email = _email;
        owner = msg.sender;
    }

    function mudarEmail(string _novoEmail) public returns (bool) {
        //verificar se a pessoa que esta executando é o dono do contrato
        if (msg.sender == owner) {
            email = _novoEmail;
            LogPersonEmailAlterado(owner, _novoEmail);
        } else {
            revert();
        }
    }

    event LogPersonEmailAlterado(address _pessoa, string _emailAlterado);
}