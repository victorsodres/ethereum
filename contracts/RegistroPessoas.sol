pragma solidity ^0.4.18;

contract RegistroPessoas {
    address[] public listaContaPessoas;
    mapping(address => address) public mapaPessoas;
    uint public size;

    event LogPersonSalvaNoRegistro(address _contaPessoa, address _contaContratoPessoa, bool _inserido); 

    function salvaPessoas(address enderecoContratoPessoa) public returns(bool) {
        //mapaPessoas[msg.sender] == null (OBS: solidity não tem null toda variavel é setada com valor 0 por default)
        require(mapaPessoas[msg.sender] == 0x0);
         
        listaContaPessoas.push(msg.sender);
        mapaPessoas[msg.sender] = enderecoContratoPessoa;  
        size++;
        LogPersonSalvaNoRegistro(msg.sender, this, true);
    }

    function getTamanhoRegistro() public view returns(uint) {
        return listaContaPessoas.length;
    }
}