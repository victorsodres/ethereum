pragma solidity ^0.4.18;

contract Owner {
    address public owner;

    modifier apenasDono() {
        require(msg.sender == owner);
        _;
    }
}

contract RegistroPessoas is Owner {
    address[] public registro;
    mapping(address => address) mapaPessoas;
    
    uint256 limitContract=200;
    address public novoContrato;

    // modifier apenasLimit() {
    //     require (limitContract <= registro.length);
    //     _;
    // }

    function salvaPessoas(address _contrato) public returns(bool) {
        if (limitContract <= registro.length) {
            registro.push(msg.sender);
            mapaPessoas[msg.sender] = _contrato;  
            return true;
        } else {
            return false;
        }
    }
    function setNovoContrato(address _novoContrato) public apenasDono {
        novoContrato = _novoContrato;
    }
}

contract Person is Owner {
    string public nome;
    string public cpf;
    string public dataNascimento;
    string public email;

    event LogPersonEmailAlterado(address _pessoa, string _emailAlterado);
    event LogPersonSalvaNoRegistro(address _contaPessoa, address _contaContratoPessoa); 

    function Person(string _nome, string _cpf, string _dataNascimento, string _email, address _enderecoRegistroPessoas) public {
        nome = _nome;
        cpf = _cpf;
        dataNascimento = _dataNascimento;
        email = _email;
        owner = msg.sender;

        if (RegistroPessoas(_enderecoRegistroPessoas).salvaPessoas(this)) {
            LogPersonSalvaNoRegistro(msg.sender, this);
        } else {
            address novoContrato = RegistroPessoas(_enderecoRegistroPessoas).novoContrato();
            RegistroPessoas(novoContrato).salvaPessoas(this);
        }
    }

    function mudarEmail(string _novoEmail) public apenasDono {
        //verificar se a pessoa que esta executando é o dono do contrato
        email = _novoEmail;
        LogPersonEmailAlterado(owner, _novoEmail);
    }

}