-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2024-04-26 21:06:55 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE t_bairro (
    cd_bairro      NUMBER(8) NOT NULL,
    cd_cidade      NUMBER(8) NOT NULL,
    nm_bairro      VARCHAR2(45),
    nm_zona_bairro VARCHAR2(20)
)
LOGGING
    ENABLE ROW MOVEMENT;

COMMENT ON COLUMN t_bairro.cd_bairro IS
    'Esta coluna irá receber o codigo do bairro e seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_bairro.cd_cidade IS
    'Esta coluna irá receber o codigo da cidade e seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_bairro.nm_bairro IS
    'Esta coluna ira receber o nome do Bairro. Esse conteúdo é obrigatório.';

COMMENT ON COLUMN t_bairro.nm_zona_bairro IS
    'Esta coluna irá receber a localização da zona onde se encontra o bairro. Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro.'
    ;

ALTER TABLE t_bairro ADD CONSTRAINT pk_mc_bairro PRIMARY KEY ( cd_bairro );

CREATE TABLE t_categoria_prod (
    cd_categoria NUMBER NOT NULL,
    tp_categoria CHAR(1) NOT NULL,
    ds_categoria VARCHAR2(500) NOT NULL,
    dt_inicio    DATE,
    dt_termino   DATE,
    st_categoria CHAR(1) NOT NULL
)
LOGGING;

COMMENT ON COLUMN t_categoria_prod.cd_categoria IS
    'Essa coluna irá armazenar a chave primária da tabela de categoria de produtos . Cada categoria nova cadastrada  será acionada a Sequence  SQ_MC_CATEGORIA que se encarregará de gerar o próximo número único da categoria..'
    ;

COMMENT ON COLUMN t_categoria_prod.tp_categoria IS
    'Nessa  coluna  será  armazenada o tipo de categoria. Seu conteúdo deve ser obrigatório.';

COMMENT ON COLUMN t_categoria_prod.ds_categoria IS
    'Essa coluna irá armazenar descrição da categoria de produtos. Cada categoria tem uma  descrição única e serve para organizar os produtos em categorias simliares, melhorando a tomada de decisão.'
    ;

COMMENT ON COLUMN t_categoria_prod.dt_inicio IS
    'Essa coluna irá receber  a data de início da categoria. Seu formato é dd/mm/yyyy e seu conteúdo deve ser sempre  obrigatório.';

COMMENT ON COLUMN t_categoria_prod.dt_termino IS
    'Essa coluna irá receber  a data de encerramento  da categoria. Seu formato é dd/mm/yyyy e seu conteúdo deve ser sempre  opcional. Conteúdo obrigatório significa que a categoria foi encerrada a partir da data término. Já o conteúdo opcional indica que a categoria está ativa e operante.'
    ;

COMMENT ON COLUMN t_categoria_prod.st_categoria IS
    'Essa coluna irá armazenar o stauts da categoria. Os valores permitidos aqui são: A(tivo) e I(nativo).';

ALTER TABLE t_categoria_prod ADD CONSTRAINT pk_categoria PRIMARY KEY ( cd_categoria );

CREATE TABLE t_cidade (
    cd_cidade NUMBER(8) NOT NULL,
    sg_estado CHAR(2) NOT NULL,
    nm_cidade VARCHAR2(60) NOT NULL,
    cd_ibge   NUMBER(8),
    nr_ddd    NUMBER(3)
)
LOGGING
    ENABLE ROW MOVEMENT;

COMMENT ON COLUMN t_cidade.cd_cidade IS
    'Esta coluna irá receber o codigo da cidade e seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_cidade.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conteúdo é obrigatório.';

COMMENT ON COLUMN t_cidade.nm_cidade IS
    'Esta coluna ira receber o nome da Cidade. Esse conteúdo é obrigatório.';

COMMENT ON COLUMN t_cidade.cd_ibge IS
    'Esta coluna irá receber o código do IBGE que fornece informações para geração da NFe.';

COMMENT ON COLUMN t_cidade.nr_ddd IS
    'Esta coluna irá receber o número do DDD da cidade para ser utilizado no contato telefônico. Seu conteudo é opcional.';

ALTER TABLE t_cidade ADD CONSTRAINT pk_mc_cidade PRIMARY KEY ( cd_cidade );

CREATE TABLE t_cli_fisica (
    nr_cliente        NUMBER(10) NOT NULL,
    dt_nascimento     DATE NOT NULL,
    fl_sexo_biologico CHAR(1) NOT NULL,
    ds_genero         VARCHAR2(100),
    nr_cpf            VARCHAR2(14) NOT NULL
)
LOGGING;

COMMENT ON COLUMN t_cli_fisica.nr_cliente IS
    'Essa coluna irá armazenar o código único do cliente.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da tabela NC_CLIENTE. '
    ;

COMMENT ON COLUMN t_cli_fisica.dt_nascimento IS
    'Essa coluna irá armazenar a data de nascimento do cliente. Seu conteúdo deve ser obrigatório. '
    ;

COMMENT ON COLUMN t_cli_fisica.fl_sexo_biologico IS
    'Essa coluna irá armazenar o sexo biológico do cliente.Seu conteúdo deve ser obrigatório.. '
    ;

COMMENT ON COLUMN t_cli_fisica.ds_genero IS
    'Genero do sexo do Cliente. Seu conteúdo deve ser obrigatório.';

COMMENT ON COLUMN t_cli_fisica.nr_cpf IS
    'Essa coluna irá armazenar o número do CPF do cliente.Seu conteúdo deve ser obrigatório. '
    ;

ALTER TABLE t_cli_fisica ADD CONSTRAINT pk_cli_fisica PRIMARY KEY ( nr_cliente );

CREATE TABLE t_cli_juridica (
    nr_cliente   NUMBER(10) NOT NULL,
    dt_fundacao  DATE,
    nr_cnpj      VARCHAR2(20),
    nr_inscr_est VARCHAR2(15)
)
LOGGING;

COMMENT ON COLUMN t_cli_juridica.nr_cliente IS
    'Essa coluna irá armazenar o código único do cliente.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da tabela NC_CLIENTE. '
    ;

COMMENT ON COLUMN t_cli_juridica.dt_fundacao IS
    'Essa coluna irá armazenar data  de fundação do cliente.Seu conteúdo deve ser obrigatório.'
    ;

COMMENT ON COLUMN t_cli_juridica.nr_cnpj IS
    'Essa coluna irá armazenar o  numero do CNPJ do cliente.Seu conteúdo deve ser obrigatório.'
    ;

COMMENT ON COLUMN t_cli_juridica.nr_inscr_est IS
    'Essa coluna irá armazenar o  numero da Inscrição Estadual  do cliente.Seu conteúdo deve ser opcional'
    ;

ALTER TABLE t_cli_juridica ADD CONSTRAINT pk_cli_juridica PRIMARY KEY ( nr_cliente );

CREATE TABLE t_cliente (
    nr_cliente      NUMBER(10) NOT NULL,
    nm_cliente      VARCHAR2(160) NOT NULL,
    qt_estrelas     NUMBER(1),
    vl_medio_compra NUMBER(10, 2),
    st_cliente      CHAR(1),
    ds_email        VARCHAR2(100),
    nr_telefone     VARCHAR2(20),
    nm_login        VARCHAR2(50) NOT NULL,
    ds_senha        VARCHAR2(50) NOT NULL
)
LOGGING;

COMMENT ON COLUMN t_cliente.nr_cliente IS
    'Essa coluna irá armazenar o código único do cliente.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual terá sempre o número disponivel para uso.'
    ;

COMMENT ON COLUMN t_cliente.nm_cliente IS
    'Essa coluna irá armazenar o nome do cliente.Seu conteúdo deve ser obrigatório.';

COMMENT ON COLUMN t_cliente.qt_estrelas IS
    'Essa coluna irá armazenar a quantiade de estrelas do cliente.Seu conteúdo deve ser obrigatório e ser possível de estar entre 1 e 5 estrelas.'
    ;

COMMENT ON COLUMN t_cliente.vl_medio_compra IS
    'Essa coluna irá armazenar o valor  médio de gastos feito pelo cliente.Seu conteúdo deve ser obrigatório e deve ser calculado diariamente.'
    ;

COMMENT ON COLUMN t_cliente.st_cliente IS
    'Essa coluna irá armazenar o stauts do cliente. Os valores permitidos aqui são: A(tivo) e I(nativo).';

COMMENT ON COLUMN t_cliente.ds_email IS
    'Essa coluna irá armazenar o email  do cliente. No minimo é esperado um email contendo o caractere (@) em seu conteúdo.'
    ;

COMMENT ON COLUMN t_cliente.nr_telefone IS
    'Essa coluna irá armazenar o número do cliente. A mascara de armazenamento deve ser: (<nr_ddd>) 99999-9999 e  deve ser utilizada pré definida.'
    ;

COMMENT ON COLUMN t_cliente.nm_login IS
    'Essa coluna irá armazenar o login de cada cliente. Seu conteúdo deve ser obrigatório e  único para cada cliente.'
    ;

COMMENT ON COLUMN t_cliente.ds_senha IS
    'Essa coluna irá armazenar a senha de cada cliente.Seu conteúdo deve ser obrigatório.'
    ;

ALTER TABLE t_cliente ADD CONSTRAINT pk_cliente PRIMARY KEY ( nr_cliente );

ALTER TABLE t_cliente ADD CONSTRAINT uk_cliente_nome_cliente UNIQUE ( nm_cliente );

CREATE TABLE t_depto (
    cd_depto NUMBER(3) NOT NULL,
    nm_depto VARCHAR2(100) NOT NULL,
    st_depto CHAR(1) NOT NULL
)
LOGGING
    ENABLE ROW MOVEMENT;

COMMENT ON COLUMN t_depto.cd_depto IS
    'Esta coluna irá receber o codigo do departamento e seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_depto.nm_depto IS
    'Esta coluna irá receber o nome do departamento e seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_depto.st_depto IS
    'Esta coluna irá receber o status do  departamento e seu conteúdo é obrigatório. Os valores possíveis são: (A)tivo e (I)nativo.'
    ;

ALTER TABLE t_depto ADD CONSTRAINT pk_depto PRIMARY KEY ( cd_depto );

CREATE TABLE t_end_cli (
    nr_cliente         NUMBER(10) NOT NULL,
    cd_logradouro_cli  NUMBER(10) NOT NULL,
    nr_end             NUMBER(8) NOT NULL,
    ds_complemento_end VARCHAR2(80),
    dt_inicio          DATE,
    dt_termino         DATE,
    st_end             CHAR(1)
)
LOGGING;

COMMENT ON COLUMN t_end_cli.nr_cliente IS
    'Esta coluna irá receber o número do cliente e seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_end_cli.cd_logradouro_cli IS
    'Esta coluna irá receber o código do logradouro do cliente e seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_end_cli.nr_end IS
    'Número do Endereço do Cliente. O número da Rua/Localidade onde o cliente está associado.';

COMMENT ON COLUMN t_end_cli.ds_complemento_end IS
    'Esta coluna irá receber o complemento do endereço do cliente e seu conteúdo pode ser opcional.';

COMMENT ON COLUMN t_end_cli.dt_inicio IS
    'Data de início do endereço associado ao cliente.';

COMMENT ON COLUMN t_end_cli.dt_termino IS
    'Data de término do endereço associado ao cliente.';

COMMENT ON COLUMN t_end_cli.st_end IS
    'Status do endereço. (A)itvo ou (I)nativo.';

ALTER TABLE t_end_cli ADD CONSTRAINT pk_end_cli PRIMARY KEY ( nr_cliente,
                                                              cd_logradouro_cli );

CREATE TABLE t_end_func (
    cd_funcionario     NUMBER(10) NOT NULL,
    cd_logradouro      NUMBER(10) NOT NULL,
    nr_end             NUMBER(8) NOT NULL,
    ds_complemento_end VARCHAR2(80),
    dt_inicio          DATE NOT NULL,
    dt_termino         DATE,
    st_end             CHAR(1) NOT NULL
)
LOGGING;

COMMENT ON COLUMN t_end_func.nr_end IS
    'Número do Endereço do Cliente. O número da Rua/Localidade onde o cliente está associado.';

COMMENT ON COLUMN t_end_func.dt_inicio IS
    'Data de início do endereço associado ao cliente.';

COMMENT ON COLUMN t_end_func.dt_termino IS
    'Data de término do endereço associado ao cliente.';

ALTER TABLE t_end_func ADD CONSTRAINT pk_end_func_pk PRIMARY KEY ( cd_funcionario,
                                                                   cd_logradouro );

CREATE TABLE t_estado (
    sg_estado CHAR(2) NOT NULL,
    nm_estado VARCHAR2(30) NOT NULL
)
LOGGING
    ENABLE ROW MOVEMENT;

COMMENT ON COLUMN t_estado.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conteúdo é obrigatório.';

COMMENT ON COLUMN t_estado.nm_estado IS
    'Esta coluna irá receber o nome do estado';

ALTER TABLE t_estado ADD CONSTRAINT pk_mc_estado PRIMARY KEY ( sg_estado );

CREATE TABLE t_funcionario (
    cd_funcionario    NUMBER(10) NOT NULL,
    cd_depto          NUMBER(3) NOT NULL,
    cd_gerente        NUMBER(10),
    nm_funcionario    VARCHAR2(160),
    dt_nascimento     DATE NOT NULL,
    fl_sexo_biologico CHAR(1),
    ds_genero         VARCHAR2(100),
    ds_cargo          VARCHAR2(80) NOT NULL,
    vl_salario        NUMBER(10, 2),
    ds_email          VARCHAR2(80),
    st_func           CHAR(1),
    dt_cadastramento  DATE,
    dt_desligamento   DATE
)
LOGGING
    ENABLE ROW MOVEMENT;

COMMENT ON COLUMN t_funcionario.cd_funcionario IS
    'Esta coluna irá receber o codigo do funcionário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_funcionario.cd_depto IS
    'Esta coluna irá receber o codigo do departamento onde o funcionario trabalha e seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_funcionario.cd_gerente IS
    'Esta coluna irá receber o codigo do gestor do funcionario e seu conteúdo é opcional.';

COMMENT ON COLUMN t_funcionario.nm_funcionario IS
    'Esta coluna irá receber o nome do funcionário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_funcionario.dt_nascimento IS
    'Esta coluna irá receber a data de nascimento do funcionário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_funcionario.fl_sexo_biologico IS
    'Esta coluna irá receber o sexo biológico do funcionário e seu conteúdo é obrigatório.Os valores permitidos aqui seriam: (F)eminino; (M)asculino'

COMMENT ON COLUMN t_funcionario.ds_genero IS
    'Esta coluna irá receber o genero atribuido ao funcionário e seu conteúdo é opcional.';

COMMENT ON COLUMN t_funcionario.ds_cargo IS
    'Esta coluna irá receber o cargo do funcionário e seu conteúdo é opcional.';

COMMENT ON COLUMN t_funcionario.vl_salario IS
    'Esta coluna irá receber o valor do salário do funcionário e seu conteúdo é opcional.';

COMMENT ON COLUMN t_funcionario.ds_email IS
    'Esta coluna irá receber o email do funcionário e seu conteúdo é opcional.';

COMMENT ON COLUMN t_funcionario.st_func IS
    'Essa coluna irá armazenar o stauts do funcionário. Os valores permitidos aqui são: A(tivo) e I(nativo).';

COMMENT ON COLUMN t_funcionario.dt_cadastramento IS
    'Data de cadastramento do Funcionario';

COMMENT ON COLUMN t_funcionario.dt_desligamento IS
    'Data de desligamento  do Funcionario. Seu conteúdo é opcional.';

ALTER TABLE t_funcionario ADD CONSTRAINT pk_funcionario PRIMARY KEY ( cd_funcionario );

CREATE TABLE t_logradouro (
    cd_logradouro NUMBER(10) NOT NULL,
    cd_bairro     NUMBER(8) NOT NULL,
    nm_logradouro VARCHAR2(160) NOT NULL,
    nr_cep        NUMBER(8)
)
LOGGING
    ENABLE ROW MOVEMENT;

COMMENT ON COLUMN t_logradouro.cd_logradouro IS
    'Esta coluna irá receber o código do logradouro e seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_logradouro.cd_bairro IS
    'Esta coluna irá receber o codigo do bairro e seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_logradouro.nm_logradouro IS
    'Esta coluna irá receber o nome do logradouro e seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_logradouro.nr_cep IS
    'Esta coluna irá receber o numero do CEP do Logradouro e seu conteúdo é obrigatório.';

ALTER TABLE t_logradouro ADD CONSTRAINT pk_logradouro PRIMARY KEY ( cd_logradouro );

CREATE TABLE t_produto (
    cd_produto        NUMBER(10) NOT NULL,
    cd_categoria      NUMBER NOT NULL,
    nr_cd_barras_prod VARCHAR2(50),
    ds_produto        VARCHAR2(80) NOT NULL,
    vl_unitario       NUMBER(8, 2) NOT NULL,
    tp_embalagem      VARCHAR2(15),
    st_produto        CHAR(1),
    vl_perc_lucro     NUMBER(8, 2),
    ds_completa_prod  VARCHAR2(4000) NOT NULL
)
LOGGING;

COMMENT ON COLUMN t_produto.cd_produto IS
    'Essa coluna irá armazenar a chave primária da tabela de produtos . A cada produto cadastrado será acionada a Sequence  SQ_MC_PRODUTO que se encarregará de gerar o próximo número único do produto.'
    ;

COMMENT ON COLUMN t_produto.cd_categoria IS
    'Essa coluna irá armazenar a chave primária da tabela de categoria de produtos . Cada categoria nova cadastrada  será acionada a Sequence  SQ_MC_CATEGORIA que se encarregará de gerar o próximo número único da categoria..'
    ;

COMMENT ON COLUMN t_produto.nr_cd_barras_prod IS
    'Essa coluna irá armazenar o número do codigo de barras  do produto. Seu conteúdo deve ser opcional.';

COMMENT ON COLUMN t_produto.ds_produto IS
    'Essa coluna irá armazenar a descrição principal do produto. Seu conteúdo deve ser  obrigatorio.';

COMMENT ON COLUMN t_produto.vl_unitario IS
    'Essa coluna irá armazenar o valor unitário do produto. Seu conteúdo deve ser > 0 ';

COMMENT ON COLUMN t_produto.tp_embalagem IS
    'Essa coluna irá armazenar o tipo de embalagem do produto. Seu conteúdo pode ser opcional.';

COMMENT ON COLUMN t_produto.st_produto IS
    'Essa coluna irá armazenar o stauts do produto. Os valores permitidos aqui são: A(tivo) e I(nativo).';

COMMENT ON COLUMN t_produto.vl_perc_lucro IS
    'Essa coluna irá armazenar o percentual  do lucro médio para cada produto. Seu conteúdo deve ser opcional.';

COMMENT ON COLUMN t_produto.ds_completa_prod IS
    'Essa coluna irá armazenar a descrição completa do produto. Seu conteúdo deve ser  obrigatorio.';

ALTER TABLE t_produto ADD CONSTRAINT pk_produto PRIMARY KEY ( cd_produto );

CREATE TABLE t_vendas (
    cd_venda             NUMBER NOT NULL,
    nr_cliente           NUMBER(10) NOT NULL,
    cd_produto           NUMBER(10) NOT NULL,
    cd_funcionario       NUMBER(10),
    dt_venda             DATE,
    hr_venda             NUMBER(2),
    nr_indice_satisfacao NUMBER(2)
)
LOGGING;

COMMENT ON COLUMN t_vendas.cd_venda IS
    'Essa coluna irá armazenar o código da venda e seu conteúdo é obrigatório.'
    ;

COMMENT ON COLUMN t_vendas.nr_cliente IS
    'Essa coluna irá armazenar o código único do cliente .Seu conteúdo deve ser obrigatório, único e preenchido a  partir da tabela NC_CLIENTE. '
    ;

COMMENT ON COLUMN t_vendas.cd_produto IS
    'Essa coluna irá armazenar a chave primária da tabela de produtos . A cada produto cadastrado será acionada a Sequence  SQ_MC_PRODUTO que se encarregará de gerar o próximo número único do produto.'
    ;

COMMENT ON COLUMN t_vendas.cd_funcionario IS
    'Esta coluna irá receber o codigo do funcionário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_vendas.dt_venda IS
    'Essa coluna  irá  receber a data e horário da venda. Seu conteudo deve ser obrigatório.';

COMMENT ON COLUMN t_vendas.hr_venda IS
    'Essa coluna  irá  receber a hora da venda. Seu conteudo deve ser obrigatório.';

COMMENT ON COLUMN t_vendas.nr_indice_satisfacao IS
    'Essa coluna  irá  receber o índice de satisfação, , computado como um valor simples de 1 a 10, onde 1 refere-se ao cliente menos satisfeito e 10 o cliente mais satisfeito. Esse índice de satisfação é opcional e informado pelo cliente ao final do atendimento.'
    ;

ALTER TABLE t_end_cli
    ADD CONSTRAINT fk_cliente_end FOREIGN KEY ( nr_cliente )
        REFERENCES t_cliente ( nr_cliente )
    NOT DEFERRABLE;

ALTER TABLE t_cli_fisica
    ADD CONSTRAINT fk_cliente_fisica FOREIGN KEY ( nr_cliente )
        REFERENCES t_cliente ( nr_cliente )
    NOT DEFERRABLE;

ALTER TABLE t_cli_juridica
    ADD CONSTRAINT fk_cliente_juridica FOREIGN KEY ( nr_cliente )
        REFERENCES t_cliente ( nr_cliente )
    NOT DEFERRABLE;

ALTER TABLE t_vendas
    ADD CONSTRAINT fk_cliente FOREIGN KEY ( nr_cliente )
        REFERENCES t_cliente ( nr_cliente )
    NOT DEFERRABLE;

ALTER TABLE t_funcionario
    ADD CONSTRAINT fk_depto_func FOREIGN KEY ( cd_depto )
        REFERENCES t_depto ( cd_depto )
    NOT DEFERRABLE;

ALTER TABLE t_end_func
    ADD CONSTRAINT fk_end_func FOREIGN KEY ( cd_funcionario )
        REFERENCES t_funcionario ( cd_funcionario )
    NOT DEFERRABLE;

ALTER TABLE t_end_func
    ADD CONSTRAINT fk_end_func_logradouro FOREIGN KEY ( cd_logradouro )
        REFERENCES t_logradouro ( cd_logradouro )
    NOT DEFERRABLE;

ALTER TABLE t_funcionario
    ADD CONSTRAINT fk_func_superior FOREIGN KEY ( cd_gerente )
        REFERENCES t_funcionario ( cd_funcionario )
    NOT DEFERRABLE;

ALTER TABLE t_vendas
    ADD CONSTRAINT fk_funcionario FOREIGN KEY ( cd_funcionario )
        REFERENCES t_funcionario ( cd_funcionario )
    NOT DEFERRABLE;

ALTER TABLE t_logradouro
    ADD CONSTRAINT fk_logradouro_bairro FOREIGN KEY ( cd_bairro )
        REFERENCES t_bairro ( cd_bairro )
    NOT DEFERRABLE;

ALTER TABLE t_end_cli
    ADD CONSTRAINT fk_logradouro_end FOREIGN KEY ( cd_logradouro_cli )
        REFERENCES t_logradouro ( cd_logradouro )
    NOT DEFERRABLE;

ALTER TABLE t_bairro
    ADD CONSTRAINT fk_mc_bairro_cidade FOREIGN KEY ( cd_cidade )
        REFERENCES t_cidade ( cd_cidade )
    NOT DEFERRABLE;

ALTER TABLE t_cidade
    ADD CONSTRAINT fk_mc_cidade_estado FOREIGN KEY ( sg_estado )
        REFERENCES t_estado ( sg_estado )
    NOT DEFERRABLE;

ALTER TABLE t_vendas
    ADD CONSTRAINT fk_produto FOREIGN KEY ( cd_produto )
        REFERENCES t_produto ( cd_produto )
    NOT DEFERRABLE;

ALTER TABLE t_produto
    ADD CONSTRAINT fk_sub_categoria_prod FOREIGN KEY ( cd_categoria )
        REFERENCES t_categoria_prod ( cd_categoria )
    NOT DEFERRABLE;

CREATE OR REPLACE TRIGGER arc_fk_arco_cli_f_t_cli_fisica BEFORE
    INSERT OR UPDATE OF nr_cliente ON t_cli_fisica
    FOR EACH ROW
DECLARE
    d NUMBER(10);
BEGIN
    SELECT
        a.nr_cliente
    INTO d
    FROM
        t_cliente a
    WHERE
        a.nr_cliente = :new.nr_cliente;

    IF ( d IS NULL OR d <> nr_cliente ) THEN
        raise_application_error(-20223, 'FK FK_CLIENTE_FISICA in Table T_CLI_FISICA violates Arc constraint on Table T_CLIENTE - discriminator column NR_CLIENTE doesn''t have value NR_CLIENTE'
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fk_arco_cli_t_cli_juridica BEFORE
    INSERT OR UPDATE OF nr_cliente ON t_cli_juridica
    FOR EACH ROW
DECLARE
    d NUMBER(10);
BEGIN
    SELECT
        a.nr_cliente
    INTO d
    FROM
        t_cliente a
    WHERE
        a.nr_cliente = :new.nr_cliente;

    IF ( d IS NULL OR d <> nr_cliente ) THEN
        raise_application_error(-20223, 'FK FK_CLIENTE_JURIDICA in Table T_CLI_JURIDICA violates Arc constraint on Table T_CLIENTE - discriminator column NR_CLIENTE doesn''t have value NR_CLIENTE'
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                             0
-- ALTER TABLE                             30
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
