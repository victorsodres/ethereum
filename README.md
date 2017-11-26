## Desenvolvimento em Ethereum - GoBlockchain [WIP]

Anotações e exercícios feitos sobre o curso sobre Desenvolver na Blockchain do Ethereum.

> Caso alguma coisa esteja errada, por favor, me corrija! ;D

### Objetivo

Criar um Smart Contract registro de Pessoa válida no blockchain do Ethereum.

### Ferramentas:

- geth
- mist
    - web3js
- solidity (lang)
    - Documentação http://solidity.readthedocs.io/en/develop/index.html

### Conceitos

- Ethereum Blockchain Transactions
    - Transferência de tokens
    - Criação de contratos
- Smart Contracts
    - São programas que são executados na blockchain;
        - Basicamente uma classe que possui atributos e métodos, o que vai pro blockchain seria a instância desta classe.
    - Quando são executados, geram um HASH que é seu identificador, e a partir dele qualquer pessoa que possui esse hash consegue executar seus métodos públicos;
    - Métodos para serem executados podem ser pagos caso necessário
        - Por exemplo, tenho um Contract de Currículo, e só deixo você ver alguma parte do currículo (no caso executar um método) se você pagar 1 Token.
    - Ao executar uma Smart Contract você está executando uma transação na rede;
    - Com o hash do contrato, ele pode ser visto através de uma ABI;
    > ABI - Application Binary Interface - Interface do contrato (json)
- Gas and Fee
    - https://ethereum.stackexchange.com/questions/3/what-is-meant-by-the-term-gas
- Wei
    - Menor fração do Ethereum
- EVM (Ethereum Virtual Machine)
    - Compila o smartcontract e envia para o blockchain
- DAPP - (Decentralized Application) *
- IPFS *
    - Rede estilo ethereum que guarda arquivos
- Oráculos
- DAO (Decentralized Autonomous Companies)
- ...

### Desenvolvimento

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

### Anotações

- Mineiradora de Ethereum
    - https://ether365mining.com/
- Blockchain privado 
    - Hyperledger - https://pt.wikipedia.org/wiki/Hyperledger
    - Corda - https://www.corda.net/
- Paratii.video
    - Startup que criou um plataforma de vídeos em blockchain
- What is a Dapp?
    - https://ethereum.stackexchange.com/questions/383/what-is-a-dapp
- What is Swarm?
    - https://ethereum.stackexchange.com/questions/375/what-is-swarm-and-what-is-it-used-for
- Startup - Blockchain solidariedade
    - Prospera - http://www.organizacaoprospera.com/sobre/
- Proof of work VS Proof of stake
    - https://www.youtube.com/watch?v=5x1X_mdo2mY
- ngrok
    - https://pplware.sapo.pt/tutoriais/networking/ngrok-tuneis-seguros/