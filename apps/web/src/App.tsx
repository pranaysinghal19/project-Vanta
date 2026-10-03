import { useState } from 'react';

type Tab = 'Today' | 'Goals' | 'Protect' | 'Community' | 'Guide';

const goals = [
  { name: 'No adult content', mode: 'Protect', progress: '12 days', accent: 'coral' },
  { name: 'Paid content spend', mode: 'Reduce', progress: '₹250 / ₹500', accent: 'violet' },
  { name: 'Gym', mode: 'Build', progress: '4 / 12', accent: 'lime' },
  { name: 'Sleep before 12', mode: 'Build', progress: '6 / 10', accent: 'lilac' },
];

function Mark({ small = false }: { small?: boolean }) {
  return <img className={small ? 'mark small' : 'mark'} src="/vanta-flow-symbol.svg" alt="Vanta Core Flow logo" />;
}

export function App() {
  const [tab, setTab] = useState<Tab>('Today');
  const [logged, setLogged] = useState(false);

  return (
    <main className="shell">
      <aside className="brand-panel">
        <div className="brand-row"><Mark /><span>vanta<span className="dot">.</span></span></div>
        <div className="hero-copy">
          <p className="eyebrow">PRIVATE ACCOUNTABILITY</p>
          <h1>Less hiding.<br/><span>More living.</span></h1>
          <p>Choose what goes. Choose what replaces it. Vanta helps you keep moving when the difficult moment arrives.</p>
        </div>
        <div className="quote">Same you. A better next.</div>
      </aside>

      <section className="app-panel">
        <header>
          <div>
            <p className="eyebrow">GOOD MORNING</p>
            <h2>You're moving again.</h2>
          </div>
          <button className="avatar" aria-label="Profile">A</button>
        </header>

        <nav className="tabs">
          {(['Today','Goals','Protect','Community','Guide'] as Tab[]).map(t => (
            <button key={t} className={tab === t ? 'active' : ''} onClick={() => setTab(t)}>{t}</button>
          ))}
        </nav>

        {tab === 'Today' && <Today logged={logged} setLogged={setLogged} />}
        {tab === 'Goals' && <Goals />}
        {tab === 'Protect' && <Protect />}
        {tab === 'Community' && <Community />}
        {tab === 'Guide' && <Guide />}
      </section>
    </main>
  );
}

function Today({logged,setLogged}:{logged:boolean;setLogged:(v:boolean)=>void}) {
  return <div className="content-grid">
    <section className="card hero-card">
      <div className="metric-big">12</div>
      <div><strong>days showing up</strong><p>Not perfect. Still moving.</p></div>
      <div className="mini-bars" aria-label="progress bars">{[35,50,68,74,64,83,92].map((h,i)=><i key={i} style={{height:`${h}%`}} />)}</div>
    </section>

    <section className="card wide">
      <div className="section-title"><h3>Today's focus</h3><span>3 of 4</span></div>
      {['No adult content','30 min movement','Read 20 minutes','Phone out of bed by 11:30'].map((x,i)=><label className="task" key={x}><input type="checkbox" defaultChecked={i<2}/><span>{x}</span></label>)}
    </section>

    <section className="card money"><p>Money kept this month</p><strong>₹2,840</strong><span>Redirected from old spending</span></section>
    <section className="card"><p>Urges interrupted</p><strong className="small-number">6</strong><span>this month</span></section>
    <section className="card"><p>Movement</p><strong className="small-number">4 / 12</strong><span>sessions</span></section>

    <section className="card wide checkin">
      <div><p className="eyebrow">QUICK CHECK-IN</p><h3>Does today reflect what really happened?</h3><p>Accuracy over perfection.</p></div>
      <button onClick={()=>setLogged(true)}>{logged ? 'Logged honestly ✓' : 'Log today'}</button>
    </section>
  </div>
}

function Goals(){return <div className="stack"><div className="section-title"><h3>Your goals</h3><button className="secondary">+ Add goal</button></div>{goals.map(g=><article className="goal" key={g.name}><span className={`goal-dot ${g.accent}`}></span><div><strong>{g.name}</strong><p>{g.mode}</p></div><b>{g.progress}</b></article>)}</div>}

function Protect(){return <div className="stack"><section className="protect-card"><div><p className="eyebrow light">ACTIVE ON THIS DEVICE</p><h3>Protection is on.</h3><p>Adult-content categories blocked. Stronger protection 11:00 PM–7:00 AM.</p></div><span className="shield">✓</span></section>{['Web & app blocking','Decision Lock · 24 hours','Emergency mode · 72 hours','Device rules','Spending controls'].map(x=><article className="row-card" key={x}><span>{x}</span><b>›</b></article>)}</div>}

function Community(){return <div className="stack"><div className="section-title"><h3>Community</h3><span>Men building more.</span></div><Post name="Rohan" body="Rough night yesterday. Logged it instead of disappearing. Went for my run this morning instead of writing the week off." stats="42 · 8 replies"/><Post name="Aman" body="Deleted the account I was spending on. ₹6k stayed mine this month. Feels like I got part of my life back." stats="59 · 12 replies"/><Post name="Karan" body="First week I've slept before midnight in months. Energy already feels different." stats="31 · 5 replies"/></div>}
function Post({name,body,stats}:{name:string;body:string;stats:string}){return <article className="post"><div className="post-head"><span className="mini-avatar">{name[0]}</span><strong>{name}</strong><small>· recently</small></div><p>{body}</p><span>♥ {stats}</span></article>}

function Guide(){return <div className="stack"><section className="guide-card"><span className="guide-avatar">R</span><div><p className="eyebrow">YOUR GUIDE</p><h3>Rohit</h3><p>Your next private check-in is Thursday at 7:00 PM.</p></div></section><article className="row-card"><span>Reschedule check-in</span><b>›</b></article><article className="row-card"><span>What we'll talk about</span><b>›</b></article><section className="card honesty"><h3>Honesty builds useful progress.</h3><p>“Do your logs reflect how the fortnight really went?” If not, that's alright. You're not being graded.</p></section></div>}
