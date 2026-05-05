-- Tabla flexible para OCR de boletas que permite valores NULL
-- Adecuada cuando algunos campos no pueden ser extraídos del documento

CREATE TABLE public.ocr (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    -- Campos extraídos del OCR (todos nullable para flexibilidad)
    folio VARCHAR(50),
    fecha DATE,
    rut_emisor VARCHAR(20),
    proveedor VARCHAR(255),
    subtotal NUMERIC(12,2),
    iva NUMERIC(12,2),
    total NUMERIC(12,2),
    medio_pago VARCHAR(50),
    -- Campos adicionales
    raw_text TEXT,
    extracted_data JSONB,
    validation JSONB,
    -- Campos de auditoría
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Índices opcionales para mejorar rendimiento de consultas comunes
-- Descomentar según sea necesario:
-- CREATE INDEX idx_ocr_folio ON public.ocr(folio) WHERE folio IS NOT NULL;
-- CREATE INDEX idx_ocr_fecha ON public.ocr(fecha) WHERE fecha IS NOT NULL;
-- CREATE INDEX idx_ocr_rut ON public.ocr(rut_emisor) WHERE rut_emisor IS NOT NULL;
-- CREATE INDEX idx_ocr_proveedor ON public.ocr(proveedor) WHERE proveedor IS NOT NULL;

-- Comentario en la tabla
COMMENT ON TABLE public.ocr IS 'Tabla para almacenar resultados de OCR de boletas/facturas. Permite NULL en todos los campos extraídos para manejar casos donde el OCR no pudo detectar cierta información.';