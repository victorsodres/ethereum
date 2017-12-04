pragma solidity ^0.4.18;

contract Owned {

  address public owner;
  function Owned() public {
    owner = msg.sender;
  }

  modifier isOwner() {
    require(msg.sender == owner);
    _;
  }
}

contract Destroyer is Owned {
  function destroy() isOwner public {
    selfdestruct(owner);
  }
}

contract RegistroProfessor {
  mapping(address => address) private registro;
  address[] public contas;
  event EventoRegistro(address _contaProfessor, address _contaContratoProfessor);
  function novoContratoProfessor (address _pessoa, address _contrato) public {
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

contract Professor is Owned {
    address enderecoContratoProfessor;
    uint16 public score;
    string public descricao;
    address REGISTRO_PROFESSORES_ADDRESS;
    
    mapping(int => Curso) public listaCursos;

    event LogCursoGerado(int codigoCurso);

    struct Curso {
        int codigoCurso;
        int8 qtdPessoasLimite;
        string nomeCurso;
        string descricao;
        int8 qtdHoras;
        uint8 _score;        
        uint8[] votos;
        address[] enderecoContratoAluno;
        mapping(address => bool) mapaAlunos;
        mapping(uint8 => string) comentarios;
    }

    function Professor(address _enderecoContratoProfessor, string _descricao) public {
        enderecoContratoProfessor = _enderecoContratoProfessor;
        descricao = _descricao;
    }

    function gerarInscricao(address enderecoContratoAluno, int codigoCurso) public {
        // require(listaCursos[codigoCurso]. != 0x0);
        Curso storage curso = listaCursos[codigoCurso];
        curso.enderecoContratoAluno.push(enderecoContratoAluno);
        // curso.mapaAlunos[enderecoContratoAluno] = false;
        listaCursos[codigoCurso]  = curso;
    }
    
    function getCurso(int _codigoCurso) public isOwner returns(uint256) {
        return listaCursos[_codigoCurso].enderecoContratoAluno.length;
    }

    function gerarCurso(int _codigoCurso, int8 _qtdPessoasLimite, string _nomeCurso, string _descricao, int8 _qtdHoras) public isOwner {
        // require(REGISTRO_PROFESSORES_ADDRESS != 0x0);
        uint8[] memory votos;
        address[] memory enderecoContratoAluno;

       listaCursos[_codigoCurso] = Curso ({
            codigoCurso: _codigoCurso,
            qtdPessoasLimite: _qtdPessoasLimite,
            nomeCurso: _nomeCurso,
            descricao: _descricao,
            qtdHoras: _qtdHoras,
            _score: 0,
            votos: votos,
            enderecoContratoAluno: enderecoContratoAluno
        });

    }

    event LogEventReputacao(address enderecoAluno, uint8 reputacao);

    function receberReputacao(address enderecoAluno, uint8 reputacao, int codigoCurso, string comentarios, bool receberCertificado) public {
        Curso storage curso = listaCursos[codigoCurso];
        require(curso.mapaAlunos[enderecoAluno]);
        curso.comentarios[reputacao] = comentarios;
        listaCursos[codigoCurso] = curso;
        curso.votos.push(reputacao);
        
        LogEventReputacao(enderecoAluno, reputacao);

        if (receberCertificado) {
            Aluno aluno = Aluno(enderecoAluno);
            aluno.gerarCertificado(this, curso.codigoCurso, curso.nomeCurso, curso.qtdHoras);
        }
        curso.mapaAlunos[enderecoAluno] = true;
    }

}

contract Aluno is Destroyer {
    address enderecoContratoPessoa;
    Certificados[] public certificados;
    
    struct Certificados {
        address enderecoContratoProfessor;
        int codigoCurso;
        int8 qtdHoras;
        string nomeCurso;
    }
    
    function gerarCertificado(address _enderecoProfessor, int codigoCurso, string nomeCurso, int8 qtdHoras) public {
        //  require(address(0) == _enderecoProfessor);         
        Certificados memory cert = Certificados ({
            enderecoContratoProfessor: _enderecoProfessor,
            codigoCurso: codigoCurso,
            qtdHoras: qtdHoras,
            nomeCurso: nomeCurso
        });
        certificados.push (cert);
        LogEventCertificado(_enderecoProfessor, codigoCurso);
    }
    
    event LogEventCertificado(address enderecoAluno, int reputacao);
    function Aluno(address _enderecoContratoPessoa) public {
        enderecoContratoPessoa = _enderecoContratoPessoa;
    }
    
    function inscricaoCurso(address _enderecoContratoProfessor, int _codigoCurso) public {
        // instanciar o contrato e realizar a inscrição no curso
        Professor prof = Professor(_enderecoContratoProfessor);
        prof.gerarInscricao(this, _codigoCurso);        
    }
    
    function enviarReputacaoCurso(address _enderecoContratoProfessor, int _codigoCurso, uint8 _reputacao, string _comentarios) public {
        Professor prof = Professor(_enderecoContratoProfessor);
        prof.receberReputacao(this, _reputacao, _codigoCurso, _comentarios, true);
    }
}