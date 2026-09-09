program spacecraft_analyzer
    implicit none

    character(len=16) :: record
    character(len=1) :: alert_code
    character(len=16) :: mission_state

    integer :: battery, temperature, signal_strength
    integer :: record_count, battery_total
    integer :: temperature_total, signal_total
    integer :: warning_count, alert_count
    integer :: io_status

    real :: average_battery
    real :: average_temperature
    real :: average_signal

    record_count = 0
    battery_total = 0
    temperature_total = 0
    signal_total = 0
    warning_count = 0
    alert_count = 0

    open(unit=10, file="validated_spacecraft.txt", &
         status="old", action="read")

    do
        read(10, "(A)", iostat=io_status) record
        if (io_status /= 0) exit

        read(record(7:9), *) battery
        read(record(10:12), *) temperature
        read(record(13:15), *) signal_strength
        alert_code = record(16:16)

        record_count = record_count + 1
        battery_total = battery_total + battery
        temperature_total = temperature_total + temperature
        signal_total = signal_total + signal_strength

        if (alert_code == "W") warning_count = warning_count + 1
        if (alert_code == "A") alert_count = alert_count + 1
    end do

    close(10)

    average_battery = real(battery_total) / real(record_count)
    average_temperature = real(temperature_total) / real(record_count)
    average_signal = real(signal_total) / real(record_count)

    if (alert_count > 0) then
        mission_state = "CRITICAL"
    else if (warning_count > 0 .or. average_battery < 50.0) then
        mission_state = "CAUTION"
    else
        mission_state = "NOMINAL"
    end if

    open(unit=20, file="spacecraft_report.txt", status="replace")

    write(20, "(A,I0)") "RECORDS=", record_count
    write(20, "(A,F6.2)") "AVERAGE_BATTERY=", average_battery
    write(20, "(A,F6.2)") "AVERAGE_TEMPERATURE=", average_temperature
    write(20, "(A,F6.2)") "AVERAGE_SIGNAL=", average_signal
    write(20, "(A,I0)") "WARNINGS=", warning_count
    write(20, "(A,I0)") "ALERTS=", alert_count
    write(20, "(A,A)") "MISSION_STATE=", trim(mission_state)

    close(20)

    print *, "SPACECRAFT ANALYSIS COMPLETE"
end program spacecraft_analyzer
