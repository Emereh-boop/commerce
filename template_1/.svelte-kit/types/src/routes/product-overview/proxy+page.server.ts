// @ts-nocheck
import type { PageServerLoad } from './$types.js';
import { formSchema } from './schema.js';  // Import the simple form data

export const load = async () => {
  return {
    form: formSchema  // Return the initial form data directly (no validation)
  };
};;null as any as PageServerLoad;