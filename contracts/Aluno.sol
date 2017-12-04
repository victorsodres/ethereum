pragma solidity ^0.4.16;

import { Destroyer } from "./Destroyer.sol";
import { Professor } from "./Professor.sol";

contract Aluno is Destroyer {
    address enderecoContratoPessoa;
    Certificado[] public certificados;
    
    struct Certificado {
        address enderecoContratoProfessor;
        int codigoCurso;
        int8 qtdHoras;
        string nomeCurso;
    }

    function gerarCertificado(address enderecoProfessor, int codigoCurso, string nomeCurso, int8 qtdHoras) public isNotOwner {
        Certificado memory certificado = Certificado({
            enderecoContratoProfessor: enderecoProfessor,
            codigoCurso: codigoCurso,
            qtdHoras: qtdHoras,
            nomeCurso: nomeCurso
        });
        certificados.push(certificado);
    }
    
    function Aluno(address _enderecoContratoPessoa) public {
        enderecoContratoPessoa = _enderecoContratoPessoa;
    }
    
    function inscricaoCurso(address _enderecoContratoProfessor, int _codigoCurso) public {
        Professor professor = Professor(_enderecoContratoProfessor);
        professor.gerarInscricao(this, _codigoCurso);
    }
    
    function enviarReputacaoCurso(address _enderecoContratoProfessor, int _codigoCurso, uint8 _reputacao, string _comentarios) public {
        Professor professor = Professor(_enderecoContratoProfessor);
        professor.receberReputacao(this, _reputacao, _codigoCurso, _comentarios, true);
    }
    
}