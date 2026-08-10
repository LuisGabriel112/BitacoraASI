import { describe, expect, it } from 'vitest';
import { ipPermitida } from './accesoRed';

describe('ipPermitida', () => {
	it('permite la IP configurada', () => {
		expect(ipPermitida('189.240.215.209', '189.240.215.209')).toBe(true);
	});

	it('niega una IP que no esta en la lista', () => {
		expect(ipPermitida('1.2.3.4', '189.240.215.209')).toBe(false);
	});

	it('permite localhost sin importar la configuracion', () => {
		expect(ipPermitida('127.0.0.1', '189.240.215.209')).toBe(true);
		expect(ipPermitida('::1', '189.240.215.209')).toBe(true);
	});

	it('acepta varias IPs separadas por coma', () => {
		expect(ipPermitida('200.1.2.3', '189.240.215.209, 200.1.2.3')).toBe(true);
	});

	it('usa la IP por defecto si no hay configuracion', () => {
		expect(ipPermitida('189.240.215.209', undefined)).toBe(true);
	});
});
