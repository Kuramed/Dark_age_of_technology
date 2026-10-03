/*
  Warnings:

  - Made the column `name` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- CreateTable
CREATE TABLE "Categoria" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL,
    "descricao" TEXT
);

-- CreateTable
CREATE TABLE "Curso" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "idInstrutor" INTEGER NOT NULL,
    "idCategoria" INTEGER NOT NULL,
    "nivel" TEXT NOT NULL,
    "dataPublicacao" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "totalAulas" INTEGER NOT NULL DEFAULT 0,
    "totalHoras" REAL NOT NULL DEFAULT 0,
    CONSTRAINT "Curso_idInstrutor_fkey" FOREIGN KEY ("idInstrutor") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Curso_idCategoria_fkey" FOREIGN KEY ("idCategoria") REFERENCES "Categoria" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Modulo" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "idCurso" INTEGER NOT NULL,
    "titulo" TEXT NOT NULL,
    "ordem" INTEGER NOT NULL,
    CONSTRAINT "Modulo_idCurso_fkey" FOREIGN KEY ("idCurso") REFERENCES "Curso" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Aula" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "idModulo" INTEGER NOT NULL,
    "titulo" TEXT NOT NULL,
    "tipoConteudo" TEXT NOT NULL,
    "urlConteudo" TEXT NOT NULL,
    "duracaoMinutos" INTEGER NOT NULL,
    "ordem" INTEGER NOT NULL,
    CONSTRAINT "Aula_idModulo_fkey" FOREIGN KEY ("idModulo") REFERENCES "Modulo" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Matricula" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "idUsuario" INTEGER NOT NULL,
    "idCurso" INTEGER NOT NULL,
    "dataMatricula" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dataConclusao" DATETIME,
    CONSTRAINT "Matricula_idUsuario_fkey" FOREIGN KEY ("idUsuario") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Matricula_idCurso_fkey" FOREIGN KEY ("idCurso") REFERENCES "Curso" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "ProgressoAula" (
    "idUsuario" INTEGER NOT NULL,
    "idAula" INTEGER NOT NULL,
    "dataConclusao" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" TEXT NOT NULL,

    PRIMARY KEY ("idUsuario", "idAula"),
    CONSTRAINT "ProgressoAula_idUsuario_fkey" FOREIGN KEY ("idUsuario") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ProgressoAula_idAula_fkey" FOREIGN KEY ("idAula") REFERENCES "Aula" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Avaliacao" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "idUsuario" INTEGER NOT NULL,
    "idCurso" INTEGER NOT NULL,
    "nota" INTEGER NOT NULL,
    "comentario" TEXT,
    "dataAvaliacao" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Avaliacao_idUsuario_fkey" FOREIGN KEY ("idUsuario") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Avaliacao_idCurso_fkey" FOREIGN KEY ("idCurso") REFERENCES "Curso" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Trilha" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "idCategoria" INTEGER NOT NULL,
    CONSTRAINT "Trilha_idCategoria_fkey" FOREIGN KEY ("idCategoria") REFERENCES "Categoria" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TrilhasCursos" (
    "idTrilha" INTEGER NOT NULL,
    "idCurso" INTEGER NOT NULL,
    "ordem" INTEGER NOT NULL,

    PRIMARY KEY ("idTrilha", "idCurso"),
    CONSTRAINT "TrilhasCursos_idTrilha_fkey" FOREIGN KEY ("idTrilha") REFERENCES "Trilha" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "TrilhasCursos_idCurso_fkey" FOREIGN KEY ("idCurso") REFERENCES "Curso" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Certificado" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "idUsuario" INTEGER NOT NULL,
    "idCurso" INTEGER,
    "idTrilha" INTEGER,
    "codigoVerificacao" TEXT NOT NULL,
    "dataEmissao" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Certificado_idUsuario_fkey" FOREIGN KEY ("idUsuario") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Certificado_idCurso_fkey" FOREIGN KEY ("idCurso") REFERENCES "Curso" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Certificado_idTrilha_fkey" FOREIGN KEY ("idTrilha") REFERENCES "Trilha" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Plano" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL,
    "descricao" TEXT,
    "preco" REAL NOT NULL,
    "duracaoMeses" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "Assinatura" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "idUsuario" INTEGER NOT NULL,
    "idPlano" INTEGER NOT NULL,
    "dataInicio" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dataFim" DATETIME NOT NULL,
    CONSTRAINT "Assinatura_idUsuario_fkey" FOREIGN KEY ("idUsuario") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Assinatura_idPlano_fkey" FOREIGN KEY ("idPlano") REFERENCES "Plano" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Pagamento" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "idAssinatura" INTEGER NOT NULL,
    "valorPago" REAL NOT NULL,
    "dataPagamento" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "metodoPagamento" TEXT NOT NULL,
    "idTransacaoGateway" TEXT NOT NULL,
    CONSTRAINT "Pagamento_idAssinatura_fkey" FOREIGN KEY ("idAssinatura") REFERENCES "Assinatura" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);
INSERT INTO "new_User" ("createdAt", "email", "id", "name", "password", "updatedAt") SELECT "createdAt", "email", "id", "name", "password", "updatedAt" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

-- CreateIndex
CREATE UNIQUE INDEX "Categoria_nome_key" ON "Categoria"("nome");

-- CreateIndex
CREATE UNIQUE INDEX "Certificado_codigoVerificacao_key" ON "Certificado"("codigoVerificacao");
