pragma solidity ^0.4.18;

contract Person {
    // Atributos
    address public accountOwner;
    string public nome;
    string public cpf;
    string public dataNascimento;
    string public email;

    function Person(string _nome, string _cpf, string _dataNascimento, string _email) public {
        nome = _nome;
        cpf = _cpf;
        dataNascimento = _dataNascimento;
        email = _email;
        accountOwner = msg.sender;
    }

    function mudarEmail(string _novoEmail) public returns (bool) {
        //verificar se a pessoa que esta executando é o dono do contrato
        if (msg.sender == accountOwner) {
            email = _novoEmail;
            LogPersonEmailAlterado(accountOwner, _novoEmail);
        } else {
            revert();
        }
    }

    event LogPersonEmailAlterado(address _pessoa, string _emailAlterado);
}