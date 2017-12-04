pragma solidity ^0.4.16;

import { Destroyer } from "./Destroyer.sol";
import { Registro } from "./Registro.sol";

contract Pessoa is Destroyer {
  string public nome;
  string public cpf;
  string public email;
  bool public cpfValido;
  uint256 public dataNascimento;
  address public registroContrato;
  address[] public validadores;
  uint8 public validacoes;

  event LogEmailAlterado(string _previousEmail, string _newEmail);
  event LogValidado(address _validador);

  function Pessoa (string _nome, string _cpf, uint256 _dataNascimento, address _registro) public {
    nome = _nome;
    cpf = _cpf;
    dataNascimento = _dataNascimento;
    registroContrato = _registro;
    Registro registro = Registro(_registro);
    if (registro.tamanho() == 0) {
        validacoes++;
    }
	registro.novoContrato(msg.sender, this, _nome);
  }
  function mudaEmail (string _novoEmail) public isOwner {
    email = _novoEmail;
    LogEmailAlterado(email, _novoEmail);
  }
  modifier isOwner() {
    require(msg.sender == owner);
    _;
  }
  function validarPessoa() public isNotOwner {
    validadores.push(msg.sender);
    validacoes += 1;
    LogValidado(msg.sender);    
  }
  function validarPessoa(address contratoPessoa) external isOwner {
    require(this != contratoPessoa);
    Pessoa pessoa = Pessoa(contratoPessoa);
    pessoa.validarPessoa();
  } 
  function retornaValidacoes() public view returns (uint8) {
    return validacoes;
  }
}