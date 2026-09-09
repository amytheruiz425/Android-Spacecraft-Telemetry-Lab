git add LICENSE README.md
git commit -m "Update author attribution"
git status# Android Spacecraft Telemetry Lab

An independent spacecraft telemetry simulation built entirely on an Android phone using Termux.

The project demonstrates how COBOL, FORTRAN and Python can cooperate in a small reliability-focused telemetry pipeline.

> This is an independent educational simulation using synthetic data. It is not affiliated with, endorsed by, or developed for NASA or any other space agency.

## Architecture

```text
Synthetic spacecraft records
            |
            v
    COBOL validation
            |
            v
    FORTRAN analysis
            |
            v
     Python JSON bridge
            |
            v
    Modern mission report
```

## Language Responsibilities

- **COBOL** validates fixed-width telemetry records.
- **FORTRAN** calculates measurement averages and mission state.
- **Python** converts the analysis into structured JSON.
- **Shell** builds and runs the complete pipeline.

## Telemetry Record Format

Each record contains 16 fixed-position characters:

```text
LAB001082024091N
```

| Positions | Field | Example |
|---|---|---|
| 1–6 | Vehicle identifier | LAB001 |
| 7–9 | Battery percentage | 082 |
| 10–12 | Temperature in Celsius | 024 |
| 13–15 | Signal strength | 091 |
| 16 | Alert code | N |

Alert codes:

- `N` — nominal
- `W` — warning
- `A` — active alert

## Synthetic Input

```text
LAB001082024091N
LAB002047038066W
LAB003019052028A
```

No real spacecraft or mission data is used.

## Requirements

Install the tools in Termux:

```bash
pkg update
pkg install gnucobol lfortran python git
```

Confirm the compilers:

```bash
cobc --version
lfortran --version
```

## Run the Lab

Make the pipeline executable:

```bash
chmod +x run_spacecraft_lab.sh
```

Run every stage:

```bash
./run_spacecraft_lab.sh
```

## Expected Mission Report

```json
{
  "project": "Android Spacecraft Telemetry Lab",
  "simulation": true,
  "affiliation": "Independent educational project",
  "telemetry": {
    "records": 3,
    "average_battery": 49.33,
    "average_temperature": 38.0,
    "average_signal": 61.67,
    "warnings": 1,
    "alerts": 1
  },
  "mission_state": "CRITICAL"
}
```

The mission state is `CRITICAL` because one validated telemetry record contains an active alert.

## Project Files

- `spacecraft_telemetry.txt` — synthetic fixed-width input
- `spacecraft_validator.cob` — COBOL validation stage
- `spacecraft_analyzer.f90` — FORTRAN numerical-analysis stage
- `spacecraft_to_json.py` — Python JSON bridge
- `run_spacecraft_lab.sh` — complete pipeline runner
- `.gitignore` — excludes generated files and executables
- `LICENSE` — MIT License

## Purpose

This project explores the relationship between historic and modern computing.

COBOL provides dependable record validation. FORTRAN performs scientific-style numerical analysis. Python presents the result in a format suitable for modern applications.

The complete simulation was developed and tested on an Android phone.

## License

Released under the MIT License.

Copyright (c) 2026 Amelia Ruiz 
