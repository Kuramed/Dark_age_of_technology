import { PartialType } from '@nestjs/swagger';
import { CreateProgressoDto } from './create-progresso.dto';

export class UpdateProgressoDto extends PartialType(CreateProgressoDto) {}
