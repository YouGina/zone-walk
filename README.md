# zone-walk
A simple Bash script that demonstrates DNSSEC zone walking by querying NSEC records for a given DNS zone. The script uses the `dig` command to retrieve NSEC records and prints the chain of existing names in the zone.

# Features
- **DNSSEC Detection**: Uses DNSSEC (+dnssec) to query NSEC records.
- **Zone Walking**: Retrieves and displays the chain of NSEC records from the provided domain.
- **Simple Implementation**: Uses common command-line tools (dig, grep, awk) and is easy to understand and modify.

# Usage
Run the script with the target domain as the first argument:
```bash
./zone-walk.sh example.com
```

### The script will:
1. Retrieve the primary nameserver for the zone.
1. Perform a DNSSEC-enabled query for the NSEC record.
1. Print the chain of NSEC records until it reaches the original domain.

# How It Works

1. Determine Nameserver:
    - Uses dig +short ns $zone | head -n1 to retrieve the first nameserver for the given domain.
1. Zone Walking Loop:
    - Initializes the current domain as the target zone.
    - In a loop, queries for the NSEC record using:
    ```bash
    dig +dnssec nsec $current @"${ns}"
    ```
    - Extracts the "next" domain from the NSEC record using grep and awk.
    - Continues until the NSEC record points back to the original zone, thereby completing the chain.
1. Output:
    - Prints each "next" domain as it is discovered.
  
# Limitations

**NSEC vs. NSEC3:**
- This script works for zones that use NSEC records. It will not function correctly for zones that utilize NSEC3.
