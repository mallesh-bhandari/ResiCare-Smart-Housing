from flask import Flask, render_template, request, redirect, url_for, session
import mysql.connector

app = Flask(__name__)
app.secret_key = "society_secret_key_mallesh"

# --- 1. Database Connection Function ---

def get_db_connection():
    return mysql.connector.connect(
        host="db",
        user="root",
        password="", 
        database="my_society_db" # Check karne ki phpMyAdmin madhe he  naav asla pahije
    )

# --- 2. Home Page Route ---

@app.route('/')
def home():
    return render_template('index.html')

# --- 3. Login Route ---

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        
        # Simple validation 
        if username == 'admin' and password == '123':
            session['user'] = username
            return redirect(url_for('dashboard'))
        else:
            return "Invalid Credentials"
    return render_template('login.html')

# --- 4. Dashboard Route ---

@app.route('/dashboard')
def dashboard():
    if 'user' not in session:
        return redirect(url_for('login'))
    
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    
    try:
        cursor.execute("SELECT COUNT(*) as total FROM flats")
        total_flats = cursor.fetchone()['total']
        
    
        stats = {
            'total_flats': total_flats,
            'total_bills': 8,
            'allotment': 7,
            'visitors': 5,
            'unresolved': 2,
            'in_progress': 3,
            'resolved': 10,
            'total_complaints': 15
        }
    except:
        stats = {'total_flats': 0, 'total_bills': 0, 'allotment': 0, 'visitors': 0}
        
    cursor.close()
    conn.close()
    return render_template('dashboard.html', stats=stats)

# --- 5. Add Flats Route ---  
                                                                          
@app.route('/add_flats', methods=['GET', 'POST'])
def add_flats():
    if 'user' not in session:
        return redirect(url_for('login'))

    if request.method == 'POST':
        flat_no = request.form['flat_no']
        floor = request.form['floor']
        block = request.form['block']
        flat_type = request.form['flat_type']
        
        conn = get_db_connection()
        cursor = conn.cursor()
        query = "INSERT INTO flats (flat_no, floor, block, type) VALUES (%s, %s, %s, %s)"
        cursor.execute(query, (flat_no, floor, block, flat_type))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('manage_flats'))
    
    return render_template('add_flats.html')

# --- 6. Manage Flats Route ---   
                                                              
@app.route('/manage_flats')
def manage_flats():
    if 'user' not in session:
        return redirect(url_for('login'))

    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM flats")
        all_flats = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('manage_flats.html', flats=all_flats)
    except Exception as e:
        return f"Error: {str(e)}"
    
# --- Add Allotment Route ---     
                                                               
@app.route('/add_allotment', methods=['GET', 'POST'])
def add_allotment():
    if 'user' not in session:
        return redirect(url_for('login'))

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    if request.method == 'POST':
        flat_id = request.form['flat_id']
        resident_name = request.form['resident_name']
        contact_no = request.form['contact_no']
        allotment_date = request.form['allotment_date']
        
        cursor.execute("INSERT INTO allotments (flat_id, resident_name, contact_no, allotment_date) VALUES (%s, %s, %s, %s)", 
                       (flat_id, resident_name, contact_no, allotment_date))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('dashboard')) # he dashboard la  redirect  honaar
    
    # Flats ch list  dropdown  dakhvnya  sathi                                         
    cursor.execute("SELECT id, flat_no FROM flats")
    flats = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('add_allotment.html', flats=flats)  


# --- Manage Allotment Route ---            
                                                                                            
@app.route('/manage_allotment')
def manage_allotment():
    if 'user' not in session:
        return redirect(url_for('login'))

    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        
        
        query = """
            SELECT allotments.*, flats.flat_no 
            FROM allotments 
            JOIN flats ON allotments.flat_id = flats.id
        """
        cursor.execute(query)
        all_allotments = cursor.fetchall()
        
        cursor.close()
        conn.close()
        return render_template('manage_allotment.html', allotments=all_allotments)
    except Exception as e:
        return f"Error: {str(e)}" 
    
# --- Add Bills Route ---  
                                                                                                                                  
@app.route('/add_bills', methods=['GET', 'POST'])
def add_bills():
    if 'user' not in session:
        return redirect(url_for('login'))

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    if request.method == 'POST':
        allotment_id = request.form['allotment_id']
        bill_month = request.form['bill_month']
        bill_amount = request.form['bill_amount']
        
        cursor.execute("INSERT INTO bills (allotment_id, bill_month, bill_amount) VALUES (%s, %s, %s)", 
                       (allotment_id, bill_month, bill_amount))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('manage_bills')) 
    
    
    query = """
        SELECT allotments.id, flats.flat_no, allotments.resident_name 
        FROM allotments 
        JOIN flats ON allotments.flat_id = flats.id
    """
    cursor.execute(query)
    allotted_users = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('add_bills.html', users=allotted_users)  

# --- Manage Bills Route ---       
                                                            
@app.route('/manage_bills')
def manage_bills():
    if 'user' not in session:
        return redirect(url_for('login'))

    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        
        
        query = """
            SELECT bills.*, flats.flat_no, allotments.resident_name 
            FROM bills 
            JOIN allotments ON bills.allotment_id = allotments.id
            JOIN flats ON allotments.flat_id = flats.id
            ORDER BY bills.created_at DESC
        """
        cursor.execute(query)
        all_bills = cursor.fetchall()
        
        cursor.close()
        conn.close()
        return render_template('manage_bills.html', bills=all_bills)
    except Exception as e:
        return f"Error: {str(e)}"    
    
    
    
# --- Manage Complaints Route ---           -----------------------                                                   

    
# --- Add Visitors Route ---                                                                                        
@app.route('/add_visitors', methods=['GET', 'POST'])
def add_visitors():
    if 'user' not in session:
        return redirect(url_for('login'))

    if request.method == 'POST':
        v_name = request.form['visitor_name']
        v_contact = request.form['contact_no']
        v_meet = request.form['whom_to_meet']
        v_flat = request.form['flat_no']
        v_reason = request.form['reason']
        
        conn = get_db_connection()
        cursor = conn.cursor()
        query = "INSERT INTO visitors (visitor_name, contact_no, whom_to_meet, flat_no, reason) VALUES (%s, %s, %s, %s, %s)"
        cursor.execute(query, (v_name, v_contact, v_meet, v_flat, v_reason))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('manage_visitors'))
    
    return render_template('add_visitors.html')  

                                                              
# --- Search Route ---                                                                             
@app.route('/search', methods=['GET', 'POST'])
def search():
    if 'user' not in session:
        return redirect(url_for('login'))
        
    
    if request.method == 'POST':
        search_query = request.form.get('query')
    else:
        search_query = request.args.get('query')

    resident_details = None
    bills = []
    complaints = []

    
    if search_query and search_query.strip():
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        # Basic Details
        cursor.execute("""
            SELECT allotments.*, flats.flat_no, flats.block, flats.floor, flats.flat_type 
            FROM allotments 
            JOIN flats ON allotments.flat_id = flats.id 
            WHERE flats.flat_no = %s OR allotments.resident_name LIKE %s
        """, (search_query, f"%{search_query}%"))
        resident_details = cursor.fetchone()

        if resident_details:
            # Bills
            cursor.execute("SELECT * FROM bills WHERE allotment_id = %s", (resident_details['id'],))
            bills = cursor.fetchall()
            # Complaints
            cursor.execute("SELECT * FROM complaints WHERE allotment_id = %s", (resident_details['id'],))
            complaints = cursor.fetchall()

        cursor.close()
        conn.close()

    return render_template('search_results.html', 
                           resident=resident_details, 
                           bills=bills, 
                           complaints=complaints, 
                           query=search_query) 
    
# report route                                                                    

@app.route('/report')
def report():
    if 'user' not in session:
        return redirect(url_for('login'))

    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        # 1. Total Collection (Sum of Bill Amounts) - 'amount' column use kiya
        cursor.execute("SELECT SUM(amount) as total_money FROM bills")
        result_money = cursor.fetchone()
        total_money = result_money['total_money'] if result_money['total_money'] else 0

        # 2. Total Residents (Count from Allotments)
        cursor.execute("SELECT COUNT(*) as total_res FROM allotments")
        total_residents = cursor.fetchone()['total_res']

        # 3. Complaints Summary (Pending vs Resolved)
        cursor.execute("SELECT status, COUNT(*) as count FROM complaints GROUP BY status")
        complaints_stats = cursor.fetchall()

        # 4. Recent Visitors (Last 5) - 'entry_time' use kiya
        cursor.execute("""
            SELECT visitors.*, allotments.resident_name 
            FROM visitors 
            JOIN allotments ON visitors.whom_to_visit = allotments.id 
            ORDER BY visitors.entry_time DESC LIMIT 5
        """)
        recent_visitors = cursor.fetchall()

        cursor.close()
        conn.close()

        return render_template('report.html', 
                               money=total_money, 
                               residents=total_residents, 
                               complaints=complaints_stats, 
                               visitors=recent_visitors)
                               
    except Exception as e:
        return f"Report Error: {str(e)}"
    
# --- Edit Flat Page ---                                                                              
@app.route('/edit_flat/<int:id>', methods=['GET', 'POST'])
def edit_flat(id):
    if 'user' not in session:
        return redirect(url_for('login'))
        
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    if request.method == 'POST':
        flat_no = request.form['flat_no']
        floor = request.form['floor']
        block = request.form['block']
        flat_type = request.form['flat_type']
        
        cursor.execute("UPDATE flats SET flat_no=%s, floor=%s, block=%s, type=%s WHERE id=%s", 
                       (flat_no, floor, block, flat_type, id))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('manage_flats'))


    cursor.execute("SELECT * FROM flats WHERE id = %s", (id,))
    flat_data = cursor.fetchone()
    cursor.close()
    conn.close()
    return render_template('edit_flat.html', flat=flat_data)        

# manage_allotment mein ----- view profle button ke liye                                               

@app.route('/view_resident/<int:id>')
def view_resident(id):
    if 'user' not in session:
        return redirect(url_for('login'))
        
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    

    sql = """
        SELECT allotments.*, flats.flat_no, flats.floor, flats.block, flats.type 
        FROM allotments 
        JOIN flats ON allotments.flat_id = flats.id 
        WHERE allotments.id = %s
    """
    cursor.execute(sql, (id,))
    resident = cursor.fetchone()
    
    cursor.close()
    conn.close()
    
    if resident:
        return render_template('view_resident.html', res=resident)
    return "Resident details not found!", 404 


# --- Bill ko Paid mark karne ke liye ---                                                                
@app.route('/pay_bill/<int:id>')
def pay_bill(id):
    if 'user' not in session:
        return redirect(url_for('login'))
        
    conn = get_db_connection()
    cursor = conn.cursor()
    # Status change karke 'Paid' karna
    cursor.execute("UPDATE bills SET status = 'Paid' WHERE id = %s", (id,))
    conn.commit()
    cursor.close()
    conn.close()
    return redirect(url_for('manage_bills'))

# --- Bill Print karne ka Route ---                                                                      

@app.route('/print_bill/<int:id>')
def print_bill(id):
    if 'user' not in session:
        return redirect(url_for('login'))
        
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    # Bill, Resident aur Flat details join karke nikalna
    sql = """
        SELECT bills.*, allotments.resident_name, flats.flat_no, flats.block
        FROM bills 
        JOIN allotments ON bills.allotment_id = allotments.id 
        JOIN flats ON allotments.flat_id = flats.id 
        WHERE bills.id = %s
    """
    cursor.execute(sql, (id,))
    bill = cursor.fetchone()
    cursor.close()
    conn.close()
    
    return render_template('print_bill.html', bill=bill)

# manage complaints ke liye routes                                                          

@app.route('/manage_complaints')
def manage_complaints():
    if 'user' not in session:
        return redirect(url_for('login'))
    
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    query = """
        SELECT complaints.*, allotments.resident_name, flats.flat_no 
        FROM complaints 
        JOIN allotments ON complaints.allotment_id = allotments.id 
        JOIN flats ON allotments.flat_id = flats.id
        ORDER BY complaints.date_reported DESC
    """
    cursor.execute(query)
    complaints_data = cursor.fetchall()
    
    cursor.close()
    conn.close()
    return render_template('manage_complaints.html', complaints=complaints_data)

@app.route('/update_complaint/<int:id>/<string:status>')
def update_complaint(id, status):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("UPDATE complaints SET status = %s WHERE id = %s", (status, id))
    conn.commit()
    cursor.close()
    conn.close()
    return redirect(url_for('manage_complaints'))

# manage visitors ke liye                                                      
# --- Manage Visitors Route (Only keep this one) ---
@app.route('/manage_visitors')
def manage_visitors():
    if 'user' not in session:
        return redirect(url_for('login'))
    
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        
        # Visitors + Resident Name + Flat No fetch karne ke liye JOIN
        query = """
            SELECT visitors.*, allotments.resident_name, flats.flat_no 
            FROM visitors 
            JOIN allotments ON visitors.whom_to_visit = allotments.id 
            JOIN flats ON allotments.flat_id = flats.id
            ORDER BY visitors.entry_time DESC
        """
        cursor.execute(query)
        visitors_data = cursor.fetchall()
        
        cursor.close()
        conn.close()
        return render_template('manage_visitors.html', visitors=visitors_data)
    except Exception as e:
        return f"Database Error: {str(e)}"

# Visitor ka Exit time update karne ke liye
@app.route('/visitor_exit/<int:id>')
def visitor_exit(id):
    conn = get_db_connection()
    cursor = conn.cursor()
    from datetime import datetime
    now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    cursor.execute("UPDATE visitors SET exit_time = %s, status = 'Out' WHERE id = %s", (now, id))
    conn.commit()
    cursor.close()
    conn.close()
    return redirect(url_for('manage_visitors'))

# --- 7. Logout ---
@app.route('/logout')
def logout():
    session.pop('user', None)
    return redirect(url_for('home'))

# resident login ke liye route likha hai                                            
@app.route('/resident_login', methods=['GET', 'POST'])
def resident_login():
    if request.method == 'POST':
        flat_no = request.form.get('flat_no')
        mobile_no = request.form.get('mobile_no')

        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        # Resident login logic: Joining flats and allotments table
        cursor.execute("""
            SELECT allotments.id, allotments.resident_name, flats.flat_no 
            FROM allotments 
            JOIN flats ON allotments.flat_id = flats.id 
            WHERE flats.flat_no = %s AND allotments.contact_no = %s
        """, (flat_no, mobile_no))
        
        resident = cursor.fetchone()
        cursor.close()
        conn.close()

        if resident:
            session['resident_id'] = resident['id']
            session['resident_name'] = resident['resident_name']
            session['flat_no'] = resident['flat_no']
            session['role'] = 'resident'
            return redirect(url_for('resident_dashboard'))
        else:
            return "Invalid Flat Number or Mobile Number!"

    return render_template('resident_login.html')

# resident dashboard banane ke liye                                                             
@app.route('/resident_dashboard')
def resident_dashboard():
    # Check karein ki resident login hai ya nahi
    if 'resident_id' not in session:
        return redirect(url_for('resident_login'))

    res_id = session['resident_id']
    
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # 1. Resident ki basic info fetch karein
    cursor.execute("SELECT * FROM allotments WHERE id = %s", (res_id,))
    resident_info = cursor.fetchone()

    # 2. Resident ke pending bills fetch karein
    cursor.execute("SELECT * FROM bills WHERE allotment_id = %s AND status = 'Pending'", (res_id,))
    pending_bills = cursor.fetchall()

    # 3. Resident ki recent complaints fetch karein
    cursor.execute("SELECT * FROM complaints WHERE allotment_id = %s ORDER BY id DESC LIMIT 3", (res_id,))
    recent_complaints = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template('resident_dashboard.html', 
                           resident=resident_info, 
                           bills=pending_bills, 
                           complaints=recent_complaints)
    
# my bills , resident build ke liye                                                             
@app.route('/my_bills')
def my_bills():
    if 'resident_id' not in session:
        return redirect(url_for('resident_login'))

    res_id = session['resident_id']
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Sirf is resident ke saare bills fetch karein (Paid aur Pending dono)
    cursor.execute("""
        SELECT * FROM bills 
        WHERE allotment_id = %s 
        ORDER BY id DESC
    """, (res_id,))
    
    user_bills = cursor.fetchall()
    cursor.close()
    conn.close()

    return render_template('my_bills.html', bills=user_bills)   

# my complaints ke kiye likha hai , resident side mein                                          
@app.route('/my_complaints', methods=['GET', 'POST'])
def my_complaints():
    if 'resident_id' not in session:
        return redirect(url_for('resident_login'))

    res_id = session['resident_id']
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    if request.method == 'POST':
        # Nayi complaint register karne ka logic
        category = request.form.get('category')
        description = request.form.get('description')
        
        cursor.execute("""
            INSERT INTO complaints (allotment_id, category, description, status) 
            VALUES (%s, %s, %s, 'Pending')
        """, (res_id, category, description))
        conn.commit()
        # Refresh karne ke liye wapas isi page par bhej rahe hain
        return redirect(url_for('my_complaints'))

    # Resident ki purani saare complaints fetch karein
    cursor.execute("SELECT * FROM complaints WHERE allotment_id = %s ORDER BY id DESC", (res_id,))
    all_complaints = cursor.fetchall()
    
    cursor.close()
    conn.close()

    return render_template('my_complaints.html', complaints=all_complaints) 


# resident profile ke liye yeh likha hai                                              

@app.route('/my_profile', methods=['GET', 'POST'])
def my_profile():
    if 'resident_id' not in session:
        return redirect(url_for('resident_login'))

    res_id = session['resident_id']
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    if request.method == 'POST':
        # Form se naya data lena
        new_name = request.form.get('resident_name')
        new_phone = request.form.get('contact_no')
        
        # Database update query
        cursor.execute("""
            UPDATE allotments 
            SET resident_name = %s, contact_no = %s 
            WHERE id = %s
        """, (new_name, new_phone, res_id))
        
        conn.commit()
        # Session update taaki dashboard par naya naam dikhe
        session['resident_name'] = new_name 
        return redirect(url_for('my_profile'))

    # Current data dikhane ke liye fetch karein
    cursor.execute("""
        SELECT a.*, f.flat_no 
        FROM allotments a 
        JOIN flats f ON a.flat_id = f.id 
        WHERE a.id = %s
    """, (res_id,))
    user_data = cursor.fetchone()
    
    cursor.close()
    conn.close()
    return render_template('my_profile.html', user=user_data)
#   pay bills ,resident ke liye                                             
# Iska naam badal kar 'resident_pay_bill' kar diya hai taaki Admin se clash na ho
@app.route('/resident_pay_bill/<int:id>')
def resident_pay_bill(id):
    if 'resident_id' not in session:
        return redirect(url_for('resident_login'))

    conn = get_db_connection()
    cursor = conn.cursor()
    # Status update
    cursor.execute("UPDATE bills SET status = 'Paid' WHERE id = %s", (id,))
    conn.commit()
    cursor.close()
    conn.close()
    return redirect(url_for('my_bills'))

# new resident ko register / sign up ke lye                                    
@app.route('/register')
def register():
    return render_template('register.html')


# resident side mein , events dekhne kiye route likha hai       
@app.route('/view_events')
def view_events():

    return render_template('view_events.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)    