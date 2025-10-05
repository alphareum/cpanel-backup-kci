import { z } from 'zod';
export declare const EventSchema: z.ZodObject<{
    id: z.ZodNumber;
    title: z.ZodString;
    slug: z.ZodString;
    summary: z.ZodNullable<z.ZodString>;
    description: z.ZodNullable<z.ZodString>;
    location: z.ZodNullable<z.ZodString>;
    starts_at: z.ZodString;
    ends_at: z.ZodNullable<z.ZodString>;
    hero_image_url: z.ZodNullable<z.ZodString>;
    is_published: z.ZodBoolean;
}, "strip", z.ZodTypeAny, {
    id: number;
    location: string | null;
    title: string;
    slug: string;
    summary: string | null;
    description: string | null;
    starts_at: string;
    ends_at: string | null;
    hero_image_url: string | null;
    is_published: boolean;
}, {
    id: number;
    location: string | null;
    title: string;
    slug: string;
    summary: string | null;
    description: string | null;
    starts_at: string;
    ends_at: string | null;
    hero_image_url: string | null;
    is_published: boolean;
}>;
export type EventRecord = z.infer<typeof EventSchema>;
export declare const UpsertEventSchema: z.ZodObject<{
    id: z.ZodOptional<z.ZodNumber>;
    location: z.ZodNullable<z.ZodString>;
    summary: z.ZodNullable<z.ZodString>;
    description: z.ZodNullable<z.ZodString>;
    starts_at: z.ZodString;
    ends_at: z.ZodNullable<z.ZodString>;
    hero_image_url: z.ZodNullable<z.ZodString>;
    is_published: z.ZodOptional<z.ZodBoolean>;
} & {
    title: z.ZodString;
    slug: z.ZodString;
}, "strip", z.ZodTypeAny, {
    location: string | null;
    title: string;
    slug: string;
    summary: string | null;
    description: string | null;
    starts_at: string;
    ends_at: string | null;
    hero_image_url: string | null;
    id?: number | undefined;
    is_published?: boolean | undefined;
}, {
    location: string | null;
    title: string;
    slug: string;
    summary: string | null;
    description: string | null;
    starts_at: string;
    ends_at: string | null;
    hero_image_url: string | null;
    id?: number | undefined;
    is_published?: boolean | undefined;
}>;
export type UpsertEventInput = z.infer<typeof UpsertEventSchema>;
export declare class EventsService {
    listPublished(): Promise<{
        id: number;
        location: string | null;
        title: string;
        slug: string;
        summary: string | null;
        description: string | null;
        starts_at: string;
        ends_at: string | null;
        hero_image_url: string | null;
        is_published: boolean;
    }[]>;
    upsertEvent(input: UpsertEventInput): Promise<{
        id: number;
        location: string | null;
        title: string;
        slug: string;
        summary: string | null;
        description: string | null;
        starts_at: string;
        ends_at: string | null;
        hero_image_url: string | null;
        is_published: boolean;
    }>;
}
