#!/usr/bin/env python3
import sys
import os
from multiprocessing import Pool
import subprocess
from pathlib import Path

def process_single_file(filepath):
    """Process a single file using the original dawis_input.py script"""
    try:
        filename = os.path.basename(filepath)
        print(f"Processing: {filename}")
        
        # Run the original dawis_input.py script
        result = subprocess.run([
            'python', '-W', 'ignore', 
            '/home/ellien/Euclid_LSB_DR1/dawis_input.py', 
            filename
        ], capture_output=True, text=True, timeout=None)  # 1 hour timeout per file
        
        if result.returncode == 0:
            print(f"✓ Successfully processed: {filename}")
            return True, filename, None
        else:
            print(f"✗ Error processing {filename}: {result.stderr}")
            return False, filename, result.stderr
            
    except subprocess.TimeoutExpired:
        print(f"✗ Timeout processing: {filename}")
        return False, filename, "Timeout"
    except Exception as e:
        print(f"✗ Exception processing {filename}: {str(e)}")
        return False, filename, str(e)

def main():
    if len(sys.argv) != 2:
        print("Usage: python process_batch.py <file_list>")
        sys.exit(1)
    
    batch_file = sys.argv[1]
    
    # Read file list
    with open(batch_file, 'r') as f:
        filepaths = [line.strip() for line in f if line.strip()]
    
    print(f"Processing batch of {len(filepaths)} files using Nfiles cores")
    
    # Process files in parallel using 8 cores
    with Pool(processes=len(filepaths)) as pool:
        results = pool.map(process_single_file, filepaths)
    
    # Summary
    successful = sum(1 for success, _, _ in results if success)
    failed = len(results) - successful
    
    print(f"\n=== BATCH SUMMARY ===")
    print(f"Total files: {len(results)}")
    print(f"Successful: {successful}")
    print(f"Failed: {failed}")
    
    if failed > 0:
        print("\nFailed files:")
        for success, filename, error in results:
            if not success:
                print(f"  - {filename}: {error}")
    
    return 0 if failed == 0 else 1

if __name__ == "__main__":
    sys.exit(main())
