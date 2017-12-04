pragma solidity ^0.4.16;

contract RegistroProfessor {
  mapping(address => address) private registro;
  address[] public contas;
  event EventoRegistro(address _contaProfessor, address _contaContratoProfessor);
  function novoContratoProfessor (address _pessoa, address _contrato, string _nome) public {
    contas.push(_pessoa);
    registro[_pessoa] = _contrato;
    EventoRegistro(_pessoa, _contrato);
  }
  function getContrato() public constant returns (address) {
    return registro[msg.sender];
  }
  function tamanho () public view returns (uint) {
    return contas.length;
  }
}