pragma solidity ^0.4.16;

import { Destroyer } from "./Destroyer.sol";
import { Pessoa } from "./Pessoa.sol";
import { ProfessorInterface } from "./ProfessorInterface.sol";
import { Aluno } from "./Aluno.sol";

contract Professor is Destroyer, ProfessorInterface {
    address enderecoContratoProfessor;
    uint16 public score;
    string public descricao;
    address REGISTRO_PROFESSORES_ADDRESS;
    
    mapping(int => Curso) public listaCursos;

    event LogCursoGerado(int codigoCurso, Curso curso);

    struct Curso {
        int codigoCurso;
        address[] enderecoContratoAluno;
        mapping(address => bool) mapaAlunos;
        mapping(uint8 => string) comentarios;
        uint8[] votos;
        int8 qtdPessoasLimite;
        string nomeCurso;
        string descricao;
        int8 qtdHoras;
        uint _score;
    }
    
    function setContratoRegistroPessoas(address _registroProfessoresAddress) external isOwner {
        REGISTRO_PROFESSORES_ADDRESS = _registroProfessoresAddress;
    }  
    
    function Professor(address _enderecoContratoProfessor, string _descricao) public {
        enderecoContratoProfessor = _enderecoContratoProfessor;
        descricao = _descricao;
    }

    function gerarInscricao(address enderecoContratoAluno, int codigoCurso) public {
        require(listaCursos[codigoCurso] != 0x0);
        Curso curso = listaCursos[codigoCurso];

        curso.enderecoContratoAluno.push(enderecoContratoAluno);
        curso.mapaAlunos[enderecoContratoAluno] = false;
    }
    
    function gerarCurso(int _codigoCurso, int8 _qtdPessoasLimite, string _nomeCurso, string _descricao, string _dataInicio, int8 _qtdHoras) external isOwner {
        require(REGISTRO_PROFESSORES_ADDRESS != 0x0);

        Curso memory curso = Curso({
            codigoCurso: _codigoCurso,
            qtdPessoasLimite: _qtdPessoasLimite,
            nomeCurso: _nomeCurso,
            descricao: _descricao,
            qtdHoras: _qtdHoras,
            mapaAlunos: 0x0,
            comentarios: 0x0,
            votos: 0x0,
            _score: 0
        });
        listaCursos[_codigoCurso] = curso;
    }

    function receberReputacao(address enderecoAluno, uint8 reputacao, int codigoCurso, string comentarios, bool receberCertificado) public {
        Curso curso = listaCursos[codigoCurso];
        require(curso.mapaAlunos[enderecoAluno]);

        // for (int i = 0; i < curso.enderecoContratoAluno().length; index++) {
            // if (curso.enderecoContratoAluno()[i] == enderecoAluno) {
        curso.comentarios[reputacao] = comentarios;
        listaCursos[codigoCurso] = curso;
        curso.votos.push(reputacao);
        if (receberCertificado) {
            Aluno aluno = Aluno(enderecoAluno);
            aluno.gerarCertificado(this, curso.codigoCurso, curso.nomeCurso, curso.qtdHoras);
        }
        curso.mapaAlunos[enderecoAluno] = true;
                // break;
            // }
     

        //
    }

}

