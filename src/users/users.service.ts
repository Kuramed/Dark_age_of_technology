import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import * as bcrypt from 'bcrypt';
@Injectable()
export class UsersService {
 constructor(private prisma: PrismaService) {}
 async create(createUserDto: CreateUserDto) {
        const salt = await bcrypt.genSalt();
    const hash = await bcrypt.hash(createUserDto.password, salt);
 return this.prisma.user.create({data: { ...createUserDto, password: hash },
    }); }
 findAll() {
 return this.prisma.user.findMany();
 }
 findOne(id: number) {
 return this.prisma.user.findUnique({ where: { id } });
 }
 async findByEmail(email: string) {
    return this.prisma.user.findUnique({
      where: { email },
    });
  }
 update(id: number, updateUserDto: UpdateUserDto) {
 return this.prisma.user.update({
 where: { id },
 data: updateUserDto,
 });
 }
 remove(id: number) {
 return this.prisma.user.delete({ where: { id } });
 }
}
