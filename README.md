# edudele

## Generación de archivos CSV desde TypeSpec

Este repositorio utiliza **TypeSpec** (`.tsp`) como formato fuente para definir los mensajes eBUS. Los archivos CSV utilizados por ebusd se generan automáticamente a partir de estos archivos TypeSpec.

### Cómo generar los archivos CSV

1. **Prerequisitos**: Asegúrate de tener Node.js instalado en tu sistema.

2. **Instalar dependencias**:
   ```bash
   npm install
   ```

3. **Compilar los archivos TypeSpec a CSV**:
   ```bash
   npm run compile-en
   ```
   
   Este comando compilará todos los archivos `.tsp` del directorio `src/` y generará los archivos CSV correspondientes en el directorio `outcsv/en/`.

4. **Para otros idiomas**, utiliza los comandos correspondientes:
   ```bash
   npm run compile-de  # Para alemán
   npm run compile-fr  # Para francés
   # etc.
   ```

### Flujo de trabajo para modificar configuraciones

1. **Edita los archivos `.tsp`** en el directorio `src/` (por ejemplo, `src/vaillant/08.hmu.tsp`)
2. **Compila** usando `npm run compile-en` (u otro idioma)
3. **Verifica** los archivos CSV generados en `outcsv/`
4. **Prueba** con ebusd usando los archivos generados

### Estructura de archivos TypeSpec

- **`src/`**: Archivos fuente TypeSpec (`.tsp`)
- **`outcsv/`**: Archivos CSV generados (no versionados, se generan localmente)
- **Archivos principales**:
  - `src/vaillant/08.hmu.tsp` - Definiciones para heat pump module
  - `src/vaillant/15.basv0.tsp` - Definiciones para VRC 700 controller
  - etc.

**Nota**: Los archivos en la carpeta `archived/` son versiones antiguas en formato CSV y ya no se mantienen. Todas las modificaciones deben realizarse en los archivos TypeSpec del directorio `src/`.

### Proceso de migración de CSV a TypeSpec

Si necesitas migrar archivos CSV antiguos al nuevo formato TypeSpec, sigue estos pasos:

#### 1. **Analizar el archivo CSV origen**
   - Localiza el archivo CSV antiguo en `ebusd-configuration-old-master/ebusd-2.1.x/en/vaillant/`
   - Examina su estructura y mensajes definidos

#### 2. **Crear el archivo TypeSpec**
   - Crea un nuevo archivo `.tsp` en `src/vaillant/` con el mismo nombre base
   - Por ejemplo: `15.basv0.csv` → `src/vaillant/15.basv0.tsp`

#### 3. **Estructura básica del archivo TypeSpec**
   ```typespec
   import "@ebusd/ebus-typespec";
   import "./_templates.tsp";
   import "./errors_inc.tsp";
   using Ebus;
   using Ebus.Num;
   using Ebus.Dtm;
   using Ebus.Str;
   namespace Vaillant;
   
   namespace NombreDispositivo {
     // Definir modelos base con @base
     // Definir mensajes con @inherit y @ext
     // Definir enums para valores
   }
   ```

#### 4. **Mapeo de elementos CSV a TypeSpec**

| CSV | TypeSpec |
|-----|----------|
| `*r,,,,,,B524,02000000` | `@base(MF, 0x24, 0x2, 0, 0, 0) model r_1 {}` |
| `r;w,,Name,,,,0200,,,tempv` | `@inherit(r_1, w_1) @ext(0x2, 0) model Name { value: tempv; }` |
| Tipos: `UCH`, `UIN`, `temp`, etc. | Usar los mismos tipos de `Ebus.Num` o `_templates.tsp` |
| `@unit`, `@divisor` | Usar decoradores TypeSpec correspondientes |

#### 5. **Casos especiales**

- **Herencia múltiple**: Archivos similares pueden heredar de otros
  ```typespec
  // 15.bass0.tsp hereda de 15.basv0.tsp
  union _includes {
    Basv0,
    Errors_inc,
  }
  ```

- **Archivos complementarios**: Si hay mensajes adicionales, crear archivos separados
  - Ejemplo: `08.hmu.tsp` (principal) + `08.hmu00.tsp` (complementario)

#### 6. **Validar la migración**
   ```bash
   npm run compile-en
   ```
   - Corregir errores de compilación
   - Verificar que los CSV generados en `outcsv/en/` sean correctos

#### 7. **Ejemplos de migraciones realizadas**
   - ✅ `15.basv0.csv` → `src/vaillant/15.basv0.tsp` (migración completa)
   - ✅ `08.hmu00.csv` → `src/vaillant/08.hmu00.tsp` (complementario)
   - ✅ `15.bass0.csv` → `src/vaillant/15.bass0.tsp` (hereda de basv0)
   - ✅ `15.bass1.csv` → `src/vaillant/15.bass1.tsp` (hereda de basv0)
   - ✅ `15.bass2.csv` → `src/vaillant/15.bass2.tsp` (hereda de basv0)
   - ✅ `15.bass3.csv` → `src/vaillant/15.bass3.tsp` (hereda de basv0)
   - ✅ `15.ctlv0.csv` → `src/vaillant/15.ctlv0.tsp` (hereda de basv0)
   - ✅ `15.ctlv1.csv` → `src/vaillant/15.ctlv1.tsp` (hereda de basv0)
   - ✅ `15.ctlv2.csv` → `src/vaillant/15.ctlv2.tsp` (hereda de basv0)
   - ✅ `15.ctlv3.csv` → `src/vaillant/15.ctlv3.tsp` (hereda de basv0)

## ebusd-configuration

This repository serves vendor specific configuration files for [ebusd](https://github.com/john30/ebusd).


**WARNING**: There is absolutely no warranty at all for using any of the files
provided here and you should definitely know what you're doing.

If you mess up these files or even just a single line in one of them, you might force your heating to weird behaviour or at the worst even damage it.

**If you don't know what you're doing: better keep your hands off!!!**

## IMPORTANT NOTICE
The old web service at [cfg.ebusd.eu](https://cfg.ebusd.eu) (https and http) is at its end of life and is subject to shutdown (no longer updated since end of 2024, complete shutdown end of 2025).

If you want to continue using web based configuration files, you need to
move to [ebusd version >= 24.1](https://github.com/john30/ebusd/releases/tag/24.1).

Alternatively you can clone the new [CDN repository](https://github.com/eBUS/ebus.github.io) locally ([see below](#using-the-cdn)), or use the old archived and no longer maintained CSV files locally from [here](archived/) (old frozen version kept for convenience).


## Usage with ebusd

For many years, the CSV file based definitions served a great purpose, the last published version of which are still kept for convenience in the [archived folder](archived/).

However, the CSV files are hard to read and understand and as such, there is a new approach of working with eBUS message defintions.

That's why the CSV files were relieved by [TypeSpec](https://typespec.io/) files that reside in the [src folder](src/).

These files are way easier to maintain and understand, especially when it comes to applying corrections or enhancements.

See the [guidelines](guidelines.md) for further reading.

### Using the CDN

For use with ebusd, the [TypeSpec files](src/) are converted to CSV by using the [eBUS TypeSpec library](https://github.com/john30/ebus-typespec) which was developed explicitly for this purpose.

The CSV output is made available via github CDN on [https://ebus.github.io/](https://ebus.github.io/) and this is used as the default definition source since [ebusd version 24.1](https://github.com/john30/ebusd/releases/tag/24.1).

The [CDN repository](https://github.com/eBUS/ebus.github.io) can also be cloned for local use by using the ["--configpath" option](https://github.com/john30/ebusd/wiki/2.-Run#message-configuration-options) to point to the desired language folder.

### Using the TypeSpec sources locally

When working on message definitions, the easiest way is to use the [eBUS TypeSpec library](https://github.com/john30/ebus-typespec) for conversion, or even better the [VS Code extension "ebus notebook"](https://marketplace.visualstudio.com/items?itemName=ebusd.ebus-notebook).


## Scan mechanism
As a central heating system usually consist of several components, there is a dedicated file for each of those and maybe even for different hardware/software versions of it.

This is reflected by the file name as well as conditional messages within a file.

For each seen device on the bus, ebusd will pick the best suiting file from the manufacturer subdirectory after reading the device's identification.
See also the [ebusd scan documentation](https://github.com/john30/ebusd/wiki/3.-Commands#scan) for details.

The file is then picked like this:
* manufacturer subdirectory
* target address: two hex digits prefix of the CSV file name
* ID part: converted to lower case, trimmed (leading/trailing spaces removed as well as up to two trailing "0" digits), remaining spaces replaced by underscore
* optional component type suffix, see below
* optional software and/or hardware version suffix (e.g. ".HWvvvv" or ".SWvvvv").
* extension: `.csv`

So, e.g. for the scan result  
`08;Vaillant;EHP00;0327;7201`  
which is
* target address: 0x08
* manufacturer 0xB5: "Vaillant"
* device id: "EHP00"
* software version: "03.27"
* hardware version "72.01"

ebusd will load the file [`src/vaillant/08.ehp.tsp`](src/vaillant/08.ehp.tsp) indirectly using e.g. the english variant [converted CSV from the CDN repository](https://github.com/eBUS/ebus.github.io/blob/main/en/vaillant/08.ehp.csv) served from 
[https://ebus.github.io/en/vaillant/08.ehp.csv](https://ebus.github.io/en/vaillant/08.ehp.csv).

Some devices share the same prefix (e.g. "ehp.*"). This is due to the fact
that the same physical unit can contain several logical circuits.


## Component type names

In the configuration files, some of the following component type names (`circuits`) are used frequently:

* `bc`: burner circuit
* `hc`: heating circuit
* `mc`: mixer circuit
* `hwc`: hot water circuit
* `cc`: circulation circuit
* `sc`: solar circuit

These are sometimes also used as suffix in filenames (e.g. `23.ehp.cc.tsp`) in order to note the component type as replacement for the device identifier not revealing the type in the first place.

For a single heating installation, a component type may be present in several instances (e.g. two mixers). In case these share the exact same message definitions (besides a different target address), this is reflected here as symbolic link to the `main` definition file.

Mixers and room controllers usually are available for more than one heating
circuit. If so, these files are available multiple times with the heating
circuit number appended, e.g. "mc2.4.tsp" for heating circuit 4. For the
primary heating circuit the number is not appended, though.


## Contact

The author can be contacted at ebusd@ebusd.eu .

