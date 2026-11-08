echo off
@echo DE3NAKE OPTIMIZATION / t.me/DE3NAKE
@echo %w%- Enabling All Logical Processors %b%
set THREADS=%NUMBER_OF_PROCESSORS% & bcdedit /set {current} numproc %NUMBER_OF_PROCESSORS%
@echo Completed.
@pause