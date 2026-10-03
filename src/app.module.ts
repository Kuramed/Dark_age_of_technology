import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UsersModule } from './users/users.module';
import { AuthModule } from './auth/auth.module'; // <--- Apenas uma importação
import { PrismaModule } from './prisma/prisma.module';
import { CategoriasModule } from './categorias/categorias.module';
import { CursosModule } from './cursos/cursos.module';
import { ModulosModule } from './modulos/modulos.module';
import { AulasModule } from './aulas/aulas.module';
import { MatriculasModule } from './matriculas/matriculas.module';
import { ProgressoModule } from './progresso/progresso.module';
import { PlanosModule } from './planos/planos.module';
import { PagamentosModule } from './pagamentos/pagamentos.module';

@Module({
  imports: [
    PrismaModule,
    UsersModule,
    AuthModule,
    CategoriasModule,
    CursosModule,
    ModulosModule,
    AulasModule,
    MatriculasModule,
    ProgressoModule,
    PlanosModule,
    PagamentosModule, // <--- Apenas uma referência aqui
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}