pragma solidity ^0.4.16;

contract ProfessorInterface {
    uint idade;
    function gerarCertificado(address enderecoContratoAluno) public;
    function inscricaoCurso(address enderecoContratoAluno, int codigoCurso) public;
    function receberReputacao(address _enderecoContratoProfessor, int _codigoCurso, uint8 _reputacao, string _comentarios) public;
}