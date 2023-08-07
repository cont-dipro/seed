import { Agency, StoreType } from '@prisma/client';

export const agencies: Agency[] = [
  {
    id: 1,
    createdAt: new Date(),
    updatedAt: new Date(),
    name: 'agency',
    storeType: StoreType.Agency,
  },
  {
    id: 2,
    createdAt: new Date(),
    updatedAt: new Date(),
    name: 'Direct Store',
    storeType: StoreType.DirectStore
  }
];
