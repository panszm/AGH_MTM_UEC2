# uec2_example_project_RnD

## Klonowanie repozytorium
```bash
git clone git@github.com:agh-riscv/uec2_example_project_RnD
```

Wszystkie komendy wywołuj z głównego folderu projektu (w tym wypadku uec2_example_project_RnD

##Inicjalizacja środowiska
```bash
. env.sh
```


##Symulacje
###Uruchamianie symulacji w trybie tekstowym
```bash
run_simulation.sh -t <nazwa_testu>
```

###Uruchamianie symulacji w trybie graficznym
```bash
run_simulation.sh -gt <nazwa_testu>
```

###Wyświetlenie listy dostępnych testów
```bash
run_simulation.sh -l
```


##Bitstream
###Generowanie bitstreamu
```bash
generate_bitstream.sh
```

###Wgrywanie bitstreamu do Basys3
```bash
program_fpga.sh
```


## Struktura projektu
```
├── env.sh                         -- konfiguracja środowiska
├── fpga                           -- pliki związane z FPGA:
│   ├── constraints                -- - pliki xdc
│   │   └── top_example_basys3.xdc --
│   ├── rtl                        -- - syntezowalne pliki związane z FPGA
│   │   └── top_example_basys3.sv  -- - moduł instansjonujący nadrzędny moduł projektu rtl (top)
│   └── scripts                    -- - skrypty (uruchamiane odpowiednimi narzędziami z tools)
│       ├── design_files.tcl       --
│       ├── generate_bitstream.tcl --
│       └── program_fpga.tcl       --
├── README.md                      --
├── results                        -- pliki wynikowe generacji bitstreamu:
│   ├── top_example_basys3.bit     -- - bitstream
│   └── warning_summary.log        -- - podsumowanie ostrzeżeń i błędów
├── rtl                            -- pliki syntezowalne
│   ├── and2.sv                    --
│   ├── top_example.sv             -- moduł nadrzędny (top)
│   └── xor2.sv                    --
├── sim                            -- pliki symulacyjne
│   ├── and2                       -- - pliki konkretnego testu:
│   │   ├── and2_tb.sv             -- - - testbench
│   │   └── and2.tcl               -- - - lista plików potrzebnych do uruchomienia testu
│   ├── run_simulation.tcl         -- - skrypt (uruchamiany przez tools/run_simulation.sh)
│   └── top_example                --
│       ├── top_example_tb.sv      --    ważne, aby pliki nazywały się tak jak folder testowy
│       └── top_example.tcl        --    i miały rozszerzenia 'tcl' oraz '_tb.sv'
└── tools                          -- narzędzia do pracy z projektem
    ├── clean.sh                   -- czyszczenie plików tymczasowych
    ├── generate_bitstream.sh      -- generacja bitstreamu (uruchamia też warning_summary.sh)
    ├── program_fpga.sh            -- wgrywanie bitstreamu do FPGA
    ├── run_simulation.sh          -- uruchamianie symulacji
    └── warning_summary.sh         -- filtrowanie ostrzeżeń i błędów z generacji bitstreamu (wynik w results)
```
