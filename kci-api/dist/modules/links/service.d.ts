import { z } from 'zod';
export declare const LinkRecordSchema: z.ZodObject<{
    id: z.ZodNumber;
    label: z.ZodString;
    url: z.ZodString;
    category: z.ZodEnum<["primary", "secondary", "social"]>;
    order: z.ZodNumber;
    is_active: z.ZodBoolean;
}, "strip", z.ZodTypeAny, {
    id: number;
    url: string;
    label: string;
    category: "primary" | "secondary" | "social";
    order: number;
    is_active: boolean;
}, {
    id: number;
    url: string;
    label: string;
    category: "primary" | "secondary" | "social";
    order: number;
    is_active: boolean;
}>;
export declare const UpsertLinkSchema: z.ZodObject<{
    id: z.ZodOptional<z.ZodNumber>;
} & {
    label: z.ZodString;
    url: z.ZodString;
    category: z.ZodDefault<z.ZodEnum<["primary", "secondary", "social"]>>;
    order: z.ZodDefault<z.ZodNumber>;
    is_active: z.ZodDefault<z.ZodBoolean>;
}, "strip", z.ZodTypeAny, {
    url: string;
    label: string;
    category: "primary" | "secondary" | "social";
    order: number;
    is_active: boolean;
    id?: number | undefined;
}, {
    url: string;
    label: string;
    id?: number | undefined;
    category?: "primary" | "secondary" | "social" | undefined;
    order?: number | undefined;
    is_active?: boolean | undefined;
}>;
export type LinkRecord = z.infer<typeof LinkRecordSchema>;
export type UpsertLinkInput = z.infer<typeof UpsertLinkSchema>;
export declare class LinksService {
    listLinks(): Promise<{
        id: number;
        url: string;
        label: string;
        category: "primary" | "secondary" | "social";
        order: number;
        is_active: boolean;
    }[]>;
    upsertLink(input: UpsertLinkInput): Promise<{
        id: number;
        url: string;
        label: string;
        category: "primary" | "secondary" | "social";
        order: number;
        is_active: boolean;
    }>;
    deleteLink(id: number): Promise<void>;
}
