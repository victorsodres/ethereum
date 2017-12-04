pragma solidity ^0.4.16;

contract Registro {

  mapping(address => address) private registro;
  address[] public contas;

  event EventoRegistro(address _contaPessoa, address _contaContratoPessoa, bool _inserido, string _nome);

  function novoContrato (address _pessoa, address _contrato, string _nome) public {
    contas.push(_pessoa);
    registro[_pessoa] = _contrato;
    EventoRegistro(_pessoa, _contrato, true, _nome);
  }

  function getContrato() public constant returns (address) {
    return registro[msg.sender];
  }
  function tamanho () public view returns (uint) {
    return contas.length;
  }
}