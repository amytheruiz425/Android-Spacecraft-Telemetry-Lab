import json
from pathlib import Path

report = {}

for line in Path("spacecraft_report.txt").read_text().splitlines():
    key, value = line.split("=", 1)
    report[key] = value.strip()

mission_report = {
    "project": "Android Spacecraft Telemetry Lab",
    "simulation": True,
    "affiliation": "Independent educational project",
    "telemetry": {
        "records": int(report["RECORDS"]),
        "average_battery": float(report["AVERAGE_BATTERY"]),
        "average_temperature": float(
            report["AVERAGE_TEMPERATURE"]
        ),
        "average_signal": float(report["AVERAGE_SIGNAL"]),
        "warnings": int(report["WARNINGS"]),
        "alerts": int(report["ALERTS"]),
    },
    "mission_state": report["MISSION_STATE"],
}

Path("mission_status.json").write_text(
    json.dumps(mission_report, indent=2) + "\n"
)

print("SPACECRAFT JSON BRIDGE COMPLETE")
