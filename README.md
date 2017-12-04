# Sandbox de desenvolvimento na Plataforma Ethereum

> Motivação do projeto:
> - Curso - Desenvolvimento em Ethereum - GoBlockchain

Meu playground sobre como Desenvolver na Blockchain do Ethereum.

> Caso alguma coisa esteja errada, por favor, me corrija! ;D

## Ferramentas:

- geth
- mist
    - web3js
- solidity (lang)
    - Documentação http://solidity.readthedocs.io/en/develop/index.html
- Truffle
    - Framework para facilitar o desenvolvimento em ethereum
- OpenZeppelin
    - Varios contratos com diversas funções utilitárias

## [Conceitos](wiki/Conceitos.md)

## Desenvolvimento

- Subir em uma rede privada para desenvolvimento geth;
- Criar conta personal.newAccount("sua frase de segurança") e setar como padrão;
- Criar mais 3 contas;
- Fazer o Mist acessar a rede privada criada com o geth;
- Criar contratos de Pessoa, Registro de Pessoa e Dono;
- Adicionar um contador na classe de Registro de pessoas;
- Não pode registrar a mesma pessoa duas vezes;

- Como saber se quem validou, validou corretamente?
- Pensar um projeto pessoal com blockchain;

- Definição do Contrato de Pessoa
    - Atributos
        - Nome - String
        - CPF - String
        - Data Nascimento - String
        - Email - String
        - Dono - Endereço
    - Métodos
        - mudarEmail::ownerOnly

#### Alguns comandos do GETH e MIST

Exemplo de inicialização do `geth`:
```
$ geth --dev --datadir "~/.ethereum-dev" --rpc --rpcapi "web3,eth,net,personal"  --rpcaddr "0.0.0.0" --rpcport "8545" 
```

- --dev //Sobe privado
- --rpc 
    - --rpcaddr "0.0.0.0"  // Default address
    - --rpcport "8545" // Default port
    - --rpcapi "web3,eth,net,personal" // Classes disponíveis
- --datadir "private"
- --mine // Ativa a mineiração

Exemplo de inicialização do `mist`:

```
$ mist --rpc http://localhost:8545  --swarmurl="http://swarm-gateways.net"
```

- --rpc
    - Apontando para o RPC que subimos no GETH
- --swarmurl
    - Caso o seu MIST não encontre a URL padrão do Swarm