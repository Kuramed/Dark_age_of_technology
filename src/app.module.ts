import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UsersModule } from './users/users.module';
import { AuthModule } from './auth/auth.module'; // <--- Apenas uma importação
import { PrismaModule } from './prisma/prisma.module';

@Module({
  imports: [
    PrismaModule,
    UsersModule,
    AuthModule, // <--- Apenas uma referência aqui
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}