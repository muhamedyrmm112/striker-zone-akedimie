import { Header } from "./components/Header";
import { Hero } from "./components/Hero";
import { About } from "./components/About";
import { Services } from "./components/Services";
import { EliteCamps } from "./components/EliteCamps";
import { ConferenceLeague } from "./components/ConferenceLeague";
import { EliteCampHighlight } from "./components/EliteCampHighlight";
import { PrivateTraining } from "./components/PrivateTraining";
import { Trainers } from "./components/Trainers";
import { Testimonials } from "./components/Testimonials";

import { Contact } from "./components/Contact";
import { Footer } from "./components/Footer";

export default function App() {
  return (
    <div className="min-h-screen bg-background">
      <Header />
      <main>
        <Hero />
        <About />
        <Services />
        <EliteCamps />
        <ConferenceLeague />
        <EliteCampHighlight />
        <PrivateTraining />
        <Trainers />
        <Testimonials />
        <Contact />
      </main>
      <Footer />
    </div>
  );
}