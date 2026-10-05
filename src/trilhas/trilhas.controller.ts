import { Controller, Get, UseGuards, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport'
import { ApiBearerAuth } from '@nestjs/swagger'
import { TrilhasService } from './trilhas.service';
import { CreateTrilhaDto } from './dto/create-trilha.dto';
import { UpdateTrilhaDto } from './dto/update-trilha.dto';

@Controller('trilhas')
export class TrilhasController {
  constructor(private readonly trilhasService: TrilhasService) {}
  
  @ApiBearerAuth('token')
  @UseGuards(AuthGuard('jwt'))
  @Post()
  create(@Body() createTrilhaDto: CreateTrilhaDto) {
    return this.trilhasService.create(createTrilhaDto);
  }

  @Get()
  findAll() {
    return this.trilhasService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.trilhasService.findOne(+id);
  }

  @ApiBearerAuth('token')
  @UseGuards(AuthGuard('jwt'))
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateTrilhaDto: UpdateTrilhaDto) {
    return this.trilhasService.update(+id, updateTrilhaDto);
  }

  @ApiBearerAuth('token')
  @UseGuards(AuthGuard('jwt'))
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.trilhasService.remove(+id);
  }
}
